//
//  Attachment.h
//  
//
//  Created by dragos on 5/9/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agenda, Beacon,Event;

NS_ASSUME_NONNULL_BEGIN

@interface Attachment : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(void) parseAttachments:(NSArray *)arrAttachments eventId:(long) eventId;
+(Attachment*) parseAttachment:(NSDictionary*) d;
+(NSArray*) getAttachmentsForEvent:(long) eventId;
-(void) deleteFile;
+(Attachment*) getAttachment:(long) unique;
-(NSData*) getAttachmentData;
-(NSString*) getRealFilePath;
@end

NS_ASSUME_NONNULL_END

#import "Attachment+CoreDataProperties.h"
