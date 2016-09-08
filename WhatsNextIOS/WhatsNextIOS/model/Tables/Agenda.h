//
//  Agenda.h
//  
//
//  Created by dragos on 5/9/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Question, User,Location;

NS_ASSUME_NONNULL_BEGIN

@interface Agenda : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(NSArray*) getAgendasForEvent:(long) eventId;
+(NSMutableArray*) parseAgendas:(NSArray*) agendas forEvent:(Event*) event;
+(void) deleteAgendasForEvent:(long) eventId;
-(NSString*) getDayString;
+(Agenda*) getAgenda:(long) unique;
-(NSString*) getSpeakerNames;
+(void) parseMyAgendas:(NSArray*) ids;
+(void) parseMandatoryAgendas:(NSArray*) ids;
+(NSArray*) getMyAgendasForEvent:(long) eventId;
+(Agenda*) getCurrentAgendaForLocation:(Location*) location;
@end

NS_ASSUME_NONNULL_END

#import "Agenda+CoreDataProperties.h"
