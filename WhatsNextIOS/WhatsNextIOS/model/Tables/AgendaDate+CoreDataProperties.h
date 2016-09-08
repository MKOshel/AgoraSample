//
//  AgendaDate+CoreDataProperties.h
//  
//
//  Created by dragos on 5/9/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AgendaDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AgendaDate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
