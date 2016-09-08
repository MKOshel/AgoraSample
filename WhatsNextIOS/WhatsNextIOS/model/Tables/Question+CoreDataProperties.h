//
//  Question+CoreDataProperties.h
//  
//
//  Created by dragos on 5/9/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Question.h"

NS_ASSUME_NONNULL_BEGIN

@interface Question (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSNumber *privacy;
@property (nullable, nonatomic, retain) NSString *question;
@property (nullable, nonatomic, retain) NSManagedObject *agenda;
@property (nullable, nonatomic, retain) NSManagedObject *user;
@property (nullable, nonatomic, retain) NSManagedObject *event;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *answers;

@end

@interface Question (CoreDataGeneratedAccessors)

- (void)addAnswersObject:(NSManagedObject *)value;
- (void)removeAnswersObject:(NSManagedObject *)value;
- (void)addAnswers:(NSSet<NSManagedObject *> *)values;
- (void)removeAnswers:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
