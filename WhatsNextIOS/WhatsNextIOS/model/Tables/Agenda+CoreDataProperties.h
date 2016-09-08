//
//  Agenda+CoreDataProperties.h
//  
//
//  Created by dragos on 5/19/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Agenda.h"

NS_ASSUME_NONNULL_BEGIN

@interface Agenda (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *agendaType;
@property (nullable, nonatomic, retain) NSNumber *availablePlaces;
@property (nullable, nonatomic, retain) NSString *dateTime;
@property (nullable, nonatomic, retain) NSString *descr;
@property (nullable, nonatomic, retain) NSDate *endTime;
@property (nullable, nonatomic, retain) NSNumber *expendable;
@property (nullable, nonatomic, retain) NSNumber *joined;
@property (nullable, nonatomic, retain) NSDate *lastUpdated;
@property (nullable, nonatomic, retain) NSNumber *mandatory;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *own;
@property (nullable, nonatomic, retain) NSDate *startTime;
@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSSet<Attachment *> *attachments;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) NSSet<Feedback *> *feedbacks;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) NSSet<Question *> *questions;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) NSSet<User *> *speakers;

@end

@interface Agenda (CoreDataGeneratedAccessors)

- (void)addAttachmentsObject:(Attachment *)value;
- (void)removeAttachmentsObject:(Attachment *)value;
- (void)addAttachments:(NSSet<Attachment *> *)values;
- (void)removeAttachments:(NSSet<Attachment *> *)values;

- (void)addFeedbacksObject:(Feedback *)value;
- (void)removeFeedbacksObject:(Feedback *)value;
- (void)addFeedbacks:(NSSet<Feedback *> *)values;
- (void)removeFeedbacks:(NSSet<Feedback *> *)values;

- (void)addQuestionsObject:(Question *)value;
- (void)removeQuestionsObject:(Question *)value;
- (void)addQuestions:(NSSet<Question *> *)values;
- (void)removeQuestions:(NSSet<Question *> *)values;

- (void)addSpeakersObject:(User *)value;
- (void)removeSpeakersObject:(User *)value;
- (void)addSpeakers:(NSSet<User *> *)values;
- (void)removeSpeakers:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
