//
//  User+CoreDataProperties.h
//  
//
//  Created by dragos on 5/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *jobTitle;
@property (nullable, nonatomic, retain) NSString *langKey;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *login;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *telefon;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSSet<Agenda *> *agendas;
@property (nullable, nonatomic, retain) NSSet<User *> *events;
@property (nullable, nonatomic, retain) NSSet<Feedback *> *feedbacks;
@property (nullable, nonatomic, retain) NSSet<Question *> *questions;
@property (nullable, nonatomic, retain) NSSet<Event *> *eventsParticipant;
@property (nullable, nonatomic, retain) NSSet<Event *> *eventsOrganizer;
@property (nullable, nonatomic, retain) NSNumber *loggedIn;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAgendasObject:(Agenda *)value;
- (void)removeAgendasObject:(Agenda *)value;
- (void)addAgendas:(NSSet<Agenda *> *)values;
- (void)removeAgendas:(NSSet<Agenda *> *)values;

- (void)addEventsObject:(User *)value;
- (void)removeEventsObject:(User *)value;
- (void)addEvents:(NSSet<User *> *)values;
- (void)removeEvents:(NSSet<User *> *)values;

- (void)addFeedbacksObject:(Feedback *)value;
- (void)removeFeedbacksObject:(Feedback *)value;
- (void)addFeedbacks:(NSSet<Feedback *> *)values;
- (void)removeFeedbacks:(NSSet<Feedback *> *)values;

- (void)addQuestionsObject:(Question *)value;
- (void)removeQuestionsObject:(Question *)value;
- (void)addQuestions:(NSSet<Question *> *)values;
- (void)removeQuestions:(NSSet<Question *> *)values;

- (void)addEventsParticipantObject:(Event *)value;
- (void)removeEventsParticipantObject:(Event *)value;
- (void)addEventsParticipant:(NSSet<Event *> *)values;
- (void)removeEventsParticipant:(NSSet<Event *> *)values;

- (void)addEventsOrganizerObject:(Event *)value;
- (void)removeEventsOrganizerObject:(Event *)value;
- (void)addEventsOrganizer:(NSSet<Event *> *)values;
- (void)removeEventsOrganizer:(NSSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END
