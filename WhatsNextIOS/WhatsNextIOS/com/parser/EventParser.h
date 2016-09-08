//
//  EventParser.h
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventParser : NSObject

+(NSMutableArray*) parseEvents:(NSArray*) events;

@end
