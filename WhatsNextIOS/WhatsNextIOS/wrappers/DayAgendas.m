//
//  DayAgendas.m
//  WhatsNextIOS
//
//  Created by dragos on 5/11/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "DayAgendas.h"

@implementation DayAgendas

-(id) init{
    if(self = [super init])
    {
        _agendas = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*)getAgendasForDay:(NSDate*)day
{
    if ([day compare:self.day] == NSOrderedSame) {
        return self.agendas;
    }
    return nil;
}


@end
