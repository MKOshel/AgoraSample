//
//  Feedback+CoreDataProperties.h
//  
//
//  Created by dragos on 5/9/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Feedback.h"

NS_ASSUME_NONNULL_BEGIN

@interface Feedback (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSNumber *privacy;
@property (nullable, nonatomic, retain) Agenda *agenda;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) Event *event;

@end

NS_ASSUME_NONNULL_END
