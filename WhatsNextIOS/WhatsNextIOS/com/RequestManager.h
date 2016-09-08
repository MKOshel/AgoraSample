//
//  RequestManager.h
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFURLSessionManager.h"

@protocol LoginComDelegate <NSObject>

@optional
-(void) onLoginResponse:(BOOL) success result:(NSDictionary*) result error:(NSError*) error;
-(void) onLogoutResponse:(BOOL) success result:(NSDictionary*) result error:(NSError*) error;
@end

@interface RequestManager : NSObject


@property(nonatomic,retain) id<LoginComDelegate> delegateLogin;

-(void) login:(NSString*) username password:(NSString*) password;
-(void) logout;
+(AFHTTPSessionManager*) getManager;
+(void) setToken;
+(void) setAuthenticated:(BOOL) authenticated;
+(BOOL) isAuthenticated;
+(void) checkAuthenticated;



@end
