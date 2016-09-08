//
//  User.h
//  
//
//  Created by dragos on 5/9/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class Question,Event,Feedback,Agenda;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

-(NSString*) name;
+(void) parseOrganizers:(NSArray*) arr eventId:(long) eventId;
+(void) parseParticipants:(NSArray *)arr eventId:(long)eventId;
+(User*) parseUser:(NSDictionary*) dict;

+(void) deleteUsersForEvent:(long) eventId;
+(User*) getLoggedInUser;
// Insert code here to declare functionality of your managed object subclass
+(User*) loginUser:(NSDictionary*)d;
@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
