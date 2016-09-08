//
//  Answer+CoreDataProperties.h
//  
//
//  Created by dragos on 5/9/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Answer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Answer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSString *answer;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) Question *question;

@end

NS_ASSUME_NONNULL_END
