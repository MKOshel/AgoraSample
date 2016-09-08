//
//  Event.h
//  
//
//  Created by dragos on 5/9/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question, User,AgendaDate,Beacon,Attachment;

NS_ASSUME_NONNULL_BEGIN

@interface Event : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(Event*) getEvent:(long) unique;
+(NSArray*)getEvents;

//dragos
+(NSArray*) getParticipantsForEvent:(long) eventId;
//dragos
+(NSArray*) getOrganizersForEvent:(long) eventId;

//dragos
+(NSMutableArray*) getDaysForEvent:(Event*) event;
+(void) deletePrivateEvents;

+(NSArray*) getPrivateEvents;
+(NSArray*) getPublicEvents;
+(NSMutableArray*) getMyDaysForEvent:(Event*) event;
-(void) deleteEventData;
@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
