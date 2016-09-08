//
//  Beacon.m
//  
//
//  Created by dragos on 5/9/16.
//
//

#import "Beacon.h"
#import "Agenda.h"
#import "Location.h"

@implementation Beacon

// Insert code here to add functionality to your managed object subclass


+(void) parseBeacons:(NSArray *)beacons eventId:(long)eventId{
    if(beacons == nil || [beacons count] == 0)
    return;
    if(eventId == 0)
        return;
    
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return;
    for(int i = 0 ; i < [beacons count] ; i++)
    {
        NSDictionary* d = [beacons objectAtIndex:i];
        NSLog(@"%@",d);
        Beacon* b = [Beacon parseBeacon:d];
        if(b != nil)
        {
            if(b.location != nil)
                b.location.event = e;
            NSLog(@"b.location.id = %@",b.location.unique);
            b.event = e;
        }
    }
    
    
    [DB save];

}

+(Beacon*) getBeaconByUUID:(NSString*) uuid{
    return [Beacon MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"uuid = %@",uuid]];
}

+(Beacon*) parseBeacon:(NSDictionary*) d
{
    NSString* unique = [RU getString:d key:@"id"];
    NSObject* dname = [d objectForKey:@"name"];
    NSString* durl = [RU getString:d key:@"url"];
    NSObject* duuid = [d objectForKey:@"uuid"];
    NSObject* dmac = [d objectForKey:@"mac"];
    
    
    if(unique == nil)
        return nil;
    
    NSString* name = [RU gs:dname];
    NSNumber* minor = [RU getLong:d key:@"minor"];
    NSNumber* major = [RU getLong:d key:@"major"];
    NSString* uuid = [RU gs:duuid];
    NSString* mac = [RU gs:dmac];
    NSNumber* fileId = [RU getLong:d key:@"fileId"];
    NSDictionary* dLoc = [d objectForKey:@"location"];
    
    Location* loc = nil;
    if(dLoc != nil)
    {
        loc = [Location parseLocation:dLoc];
    }
    
    Beacon* l = [Beacon getBeacon:unique];
    if(l == nil)
        l = [Beacon MR_createEntity];
    l.unique = unique;
    l.name = name;
    l.mac = mac;
    l.url = durl;
    l.location = loc;
    l.uuid = uuid;
    l.minor = minor;
    l.fileId = fileId;
    l.major = major;
    return l;
}


+(Beacon*) getBeacon:(NSString*) unique{
    return [Beacon MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unique = %@",unique]];
}

@end
