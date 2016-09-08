//
//  Event+CoreDataProperties.h
//  
//
//  Created by dragos on 5/13/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSDate *lastUpdated;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *privacy;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSSet<AgendaDate *> *agendaDates;
@property (nullable, nonatomic, retain) NSSet<Agenda *> *agendas;
@property (nullable, nonatomic, retain) NSSet<Feedback *> *feedbacks;
@property (nullable, nonatomic, retain) NSSet<User *> *organizers;
@property (nullable, nonatomic, retain) NSSet<User *> *participants;
@property (nullable, nonatomic, retain) NSSet<Question *> *questions;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) NSSet<Beacon *> *beacons;
@property (nullable, nonatomic, retain) NSSet<Attachment *> *attachments;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addAgendaDatesObject:(AgendaDate *)value;
- (void)removeAgendaDatesObject:(AgendaDate *)value;
- (void)addAgendaDates:(NSSet<AgendaDate *> *)values;
- (void)removeAgendaDates:(NSSet<AgendaDate *> *)values;

- (void)addAgendasObject:(Agenda *)value;
- (void)removeAgendasObject:(Agenda *)value;
- (void)addAgendas:(NSSet<Agenda *> *)values;
- (void)removeAgendas:(NSSet<Agenda *> *)values;

- (void)addFeedbacksObject:(Feedback *)value;
- (void)removeFeedbacksObject:(Feedback *)value;
- (void)addFeedbacks:(NSSet<Feedback *> *)values;
- (void)removeFeedbacks:(NSSet<Feedback *> *)values;

- (void)addOrganizersObject:(User *)value;
- (void)removeOrganizersObject:(User *)value;
- (void)addOrganizers:(NSSet<User *> *)values;
- (void)removeOrganizers:(NSSet<User *> *)values;

- (void)addParticipantsObject:(User *)value;
- (void)removeParticipantsObject:(User *)value;
- (void)addParticipants:(NSSet<User *> *)values;
- (void)removeParticipants:(NSSet<User *> *)values;

- (void)addQuestionsObject:(Question *)value;
- (void)removeQuestionsObject:(Question *)value;
- (void)addQuestions:(NSSet<Question *> *)values;
- (void)removeQuestions:(NSSet<Question *> *)values;

- (void)addBeaconsObject:(Beacon *)value;
- (void)removeBeaconsObject:(Beacon *)value;
- (void)addBeacons:(NSSet<Beacon *> *)values;
- (void)removeBeacons:(NSSet<Beacon *> *)values;

- (void)addAttachmentsObject:(Attachment *)value;
- (void)removeAttachmentsObject:(Attachment *)value;
- (void)addAttachments:(NSSet<Attachment *> *)values;
- (void)removeAttachments:(NSSet<Attachment *> *)values;

@end

NS_ASSUME_NONNULL_END
