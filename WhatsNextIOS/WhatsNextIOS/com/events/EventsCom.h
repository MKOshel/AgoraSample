//
//  EventsCom.h
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RequestManager.h"
#import "AgendasCom.h"

@protocol EventsComDelegate <NSObject>

@optional
-(void) onEventsReceived:(BOOL) success response:(NSMutableArray*) response error:(NSError*) err;
-(void) onSelectEvent:(BOOL) success response:(long)eventId error:(NSError*) err;
-(void) onEventDataReceived:(BOOL) success response:(long)eventId error:(NSError*) err;
@end

@interface EventsCom : RequestManager<AgendasComDelegate>

@property(nonatomic, retain) AgendasCom* req;
-(void) getEvents;
-(void) selectEvent:(long) eventId;


-(void) getEventData:(long) eventId;

@property(nonatomic, retain) id<EventsComDelegate> delegate;
@property(nonatomic, retain) id<AgendasComDelegate> downloadDelegate;

@end
