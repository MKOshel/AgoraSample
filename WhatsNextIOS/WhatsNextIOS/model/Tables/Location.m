//
//  Location.m
//  
//
//  Created by dragos on 5/11/16.
//
//

#import "Location.h"
#import "Agenda.h"
#import "Event.h"

@implementation Location

// Insert code here to add functionality to your managed object subclass

+(void) parseLocations:(NSArray *)locations eventId:(long)eventId{
    if(locations == nil || [locations count] == 0)
        return;
    if(eventId == 0)
        return;

    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return;
    for(int i = 0 ; i < [locations count] ; i++)
    {
        NSDictionary* d = [locations objectAtIndex:i];
        Location* l = [Location parseLocation:d];
        if(l == nil)
            continue;
        l.event = e;
    }
    [DB save];
}

+(Location*) parseLocation:(NSDictionary *)d{
    NSObject* dunique = [d objectForKey:@"id"];
    NSObject* ddescr = [d objectForKey:@"description"];
    NSObject* dname = [d objectForKey:@"name"];
    
    NSNumber* unique = [RU getLong:d key:@"id"];
    NSString* descr = [RU gs:ddescr];
    NSString* name = [RU gs:dname];
    NSNumber* latitude = [RU getDouble:d key:@"latitude"];
    NSNumber* longitude = [RU getDouble:d key:@"longitude"];
    
    Location* l = [Location getLocation:[unique longValue]];
    if(l == nil)
        l = [Location MR_createEntity];
    if([unique longValue] == 0L)
        return nil;
    l.unique = unique;
    l.name = name;
    l.descr = descr;
    l.latitude = latitude;
    l.longitude = longitude;
    return l;
}

+(Location*) getLocation:(long) unique{
    return [Location MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unique = %@",[NSNumber numberWithLong:unique]]];
}


+(void) deleteLocationsForEvent:(long) eventId{
    [Location MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"event.unique = %@", [NSNumber numberWithLong:eventId]]];
}

@end
