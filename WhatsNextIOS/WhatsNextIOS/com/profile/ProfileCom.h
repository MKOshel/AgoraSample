//
//  ProfileCom.h
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RequestManager.h"
#import "UserData.h"

@protocol ProfileComDelegate <NSObject>

@optional
-(void) onRegisterResult:(BOOL) success error:(NSError*) error;
-(void) onAccountUpdate:(BOOL) success error:(NSError*) error;

@end

@interface ProfileCom : RequestManager

-(void) registerProfile:(UserData*) data;
-(void) updateAccount:(UserData*) data;

@property(nonatomic, retain) id<ProfileComDelegate> delegate;

@end
