//
//  Location+CoreDataProperties.h
//  
//
//  Created by dragos on 5/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *descr;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) NSSet<Agenda *> *agendas;

@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addAgendasObject:(Agenda *)value;
- (void)removeAgendasObject:(Agenda *)value;
- (void)addAgendas:(NSSet<Agenda *> *)values;
- (void)removeAgendas:(NSSet<Agenda *> *)values;

@end

NS_ASSUME_NONNULL_END
