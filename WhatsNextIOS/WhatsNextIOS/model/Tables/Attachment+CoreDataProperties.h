//
//  Attachment+CoreDataProperties.h
//  
//
//  Created by dragos on 5/9/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Attachment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *unique;
@property (nullable, nonatomic, retain) NSString *blobName;
@property (nullable, nonatomic, retain) NSNumber *agendaId;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *localPath;
@property (nullable, nonatomic, retain) Agenda *agenda;
@property (nullable, nonatomic, retain) Beacon *beacon;
@property (nullable, nonatomic, retain) Event *event;
@end

NS_ASSUME_NONNULL_END
