//
//  Beacon+CoreDataProperties.h
//  
//
//  Created by dragos on 5/9/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Beacon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Beacon (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *unique;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSString *mac;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) NSNumber *typeAgenda;
@property (nullable, nonatomic, retain) NSNumber *fileId;
@property (nullable, nonatomic, retain) NSNumber *minor;
@property (nullable, nonatomic, retain) NSNumber *major;
@property (nullable, nonatomic, retain) Agenda *agenda;
@property (nullable, nonatomic, retain) Event *event;

@end

NS_ASSUME_NONNULL_END
