//
//  DayAgendas.h
//  WhatsNextIOS
//
//  Created by dragos on 5/11/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayAgendas : NSObject

@property(nonatomic, retain) NSMutableArray* agendas;
@property(nonatomic, retain) NSDate* day;


-(NSMutableArray*)getAgendasForDay:(NSDate*)day;


@end
