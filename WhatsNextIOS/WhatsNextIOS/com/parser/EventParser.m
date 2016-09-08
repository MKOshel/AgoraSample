//
//  EventParser.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "EventParser.h"
#import "Event.h"

@implementation EventParser

+(NSMutableArray*) parseEvents:(NSArray *)events{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    if(events == nil || [events count] == 0)
        return ret;
    
    
    for(int i = 0 ; i < [events count] ; i++)
    {
        NSDictionary* d = [events objectAtIndex:i];
        NSString* address = [d objectForKey:@"address"];
        NSString* endDate = [d objectForKey:@"endDate"];
        NSString* startDarte = [d objectForKey:@"startDate"];
        NSString* name= [d objectForKey:@"name"];
        long unique = [[d objectForKey:@"id"] longValue];
        BOOL privacy = [[d objectForKey:@"privacy"] boolValue];
        
        Event* e = nil;
        
        
        if(unique)
        {
            e = [Event getEvent:unique];
            if(e == nil)
                e = [Event MR_createEntity];
            e.unique = [NSNumber numberWithLong:unique];
            e.address = address;
            e.endDate = [RU parseDate:endDate];
            e.startDate = [RU parseDate:startDarte];
            e.privacy = [NSNumber numberWithBool:privacy];
            e.name = name;
            [ret addObject:e];
        }
        [DB save];
    }
    return ret;
}

@end
