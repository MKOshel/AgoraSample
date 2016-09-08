//
//  Notification+CoreDataProperties.h
//  
//
//  Created by dragos on 5/19/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Notification.h"

NS_ASSUME_NONNULL_BEGIN

@interface Notification (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *read;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *agendaId;
@property (nullable, nonatomic, retain) NSNumber *fileId;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) Agenda *agenda;
@property (nullable, nonatomic, retain) Attachment *attachment;
@property (nullable, nonatomic, retain) Beacon *beacon;

@end

NS_ASSUME_NONNULL_END
