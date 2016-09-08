//
//  Notification.h
//  
//
//  Created by dragos on 5/19/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agenda, Attachment, Beacon;

NS_ASSUME_NONNULL_BEGIN

@interface Notification : NSManagedObject

+(Notification*) getNotification:(Beacon*) b;

+(NSArray*) getNotifications;
// Insert code here to declare functionality of your managed object subclass
+(long) getUnreadCount;

+(void) addNotification:(Beacon *)b agenda:(Agenda *)a attachment:(Attachment *)att title:(NSString*) title message:(NSString*) message;
@end

NS_ASSUME_NONNULL_END

#import "Notification+CoreDataProperties.h"
