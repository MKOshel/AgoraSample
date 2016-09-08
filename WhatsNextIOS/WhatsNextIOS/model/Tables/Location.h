//
//  Location.h
//  
//
//  Created by dragos on 5/11/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agenda, Event;

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(void) parseLocations:(NSArray*) locations eventId:(long) eventId;
+(Location*) getLocation:(long) unique;
+(void) deleteLocationsForEvent:(long) eventId;
+(Location*) parseLocation:(NSDictionary*) d;

@end

NS_ASSUME_NONNULL_END

#import "Location+CoreDataProperties.h"
