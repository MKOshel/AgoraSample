//
//  Beacon.h
//  
//
//  Created by dragos on 5/9/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agenda,Location;

NS_ASSUME_NONNULL_BEGIN

@interface Beacon : NSManagedObject


+(void) parseBeacons:(NSArray*) beacons eventId:(long) eventId;
+(Beacon*) getBeacon:(NSString*) unique;
// Insert code here to declare functionality of your managed object subclass
+(Beacon*) parseBeacon:(NSDictionary*) d;
+(Beacon*) getBeaconByUUID:(NSString*) uuid;
@end

NS_ASSUME_NONNULL_END

#import "Beacon+CoreDataProperties.h"
