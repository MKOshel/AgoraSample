//
//  UserData.h
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property(nonatomic, retain) NSString* username;
@property(nonatomic, retain) NSString* password;
@property(nonatomic, retain) NSString* password2;
@property(nonatomic, retain) NSString* lastName;
@property(nonatomic, retain) NSString* firstName;
@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* phone;
@property(nonatomic, retain) NSString* jobTitle;
@property(nonatomic, retain) NSString* email;
@property(nonatomic, retain) NSString* langKey;


-(NSString*) checkEmail;
-(NSString*) checkUsername;

-(NSString*) checkpassword1;


-(NSString*) checkPassword2;

@end
