//
//  Notification.m
//  
//
//  Created by dragos on 5/19/16.
//
//

#import "Notification.h"
#import "Agenda.h"
#import "Attachment.h"
#import "Beacon.h"

@implementation Notification

// Insert code here to add functionality to your managed object subclass

+(Notification*) getNotification:(Beacon*) b{
    NSLog(@"%@",b.unique);
    return [Notification MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"beacon.unique = %@",b.unique]];
}

+(NSArray*) getNotifications{
    return [Notification MR_findAllSortedBy:@"date" ascending:NO];
}

+(long) getUnreadCount{
    return [[Notification MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"read = %@ or read = nil",[NSNumber numberWithBool:NO]]] count];
}

+(void) addNotification:(Beacon *)b agenda:(Agenda *)a attachment:(Attachment *)att title:(NSString*) title message:(NSString*) message{
    Notification* n = [Notification MR_createEntity];
    n.beacon = b;
    n.attachment = att;
    n.agenda = a;
    n.message = message;
    n.title = title;
    NSDate* d = [NSDate date];
    n.date = d;
    /*NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    n.date = destinationDate;*/
}

@end
