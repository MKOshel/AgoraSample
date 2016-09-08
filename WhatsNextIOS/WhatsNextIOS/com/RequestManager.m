//
//  RequestManager.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RequestManager.h"
#import "User.h"
#import "Notification.h"
#import "Event.h"

static AFHTTPSessionManager *manager;
static BOOL isAuthenticated;

@implementation RequestManager

+(BOOL) isAuthenticated{
    return  isAuthenticated;
}

+(void) setAuthenticated:(BOOL)authenticated{
    isAuthenticated = authenticated;
}

+(void) checkAuthenticated{
    if([SM getToken] != nil)
    {
        isAuthenticated = YES;
    }
    else
        isAuthenticated = NO;
}

+(AFHTTPSessionManager*) getManager{
    if(manager == nil)
    {
        NSURL* url = [[NSURL alloc] initWithString:@"http://nextagenda.azurewebsites.net/NextAgenda/"];
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return manager;
}

+(void) setToken{
    AFHTTPSessionManager* m = [RequestManager getManager];
    NSString* token = [SM getToken];
    if(token != nil)
    {
        [m.requestSerializer setValue:token forHTTPHeaderField:@"x-auth-token"];
    }
    else{
        [m.requestSerializer setValue:nil forHTTPHeaderField:@"x-auth-token"];
    }
    [m.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [m.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

-(void) logout{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    
    [m GET:@"api/logout" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SM resetLoginData];
        [SM setToken:nil];
        [RM setAuthenticated:NO];
        [Notification MR_deleteAllMatchingPredicate:nil];
        [DB save];
        [SM setCurrentUser:nil];
        [Event deletePrivateEvents];
        if(self.delegateLogin != nil && [self.delegateLogin respondsToSelector:@selector(onLogoutResponse:result:error:)])
        {
            [self.delegateLogin onLogoutResponse:YES result:nil error:nil];
        }
        //NSArray* arr = [Event MR_findAll];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGOUT object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegateLogin != nil && [self.delegateLogin respondsToSelector:@selector(onLogoutResponse:result:error:)])
        {
            [self.delegateLogin onLogoutResponse:NO result:nil error:error];
        }
    }];
}


-(void) login:(NSString*) username password:(NSString*) password{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSMutableDictionary* d = [[NSMutableDictionary alloc] init];
    [d setValue:password forKey:@"password"];
    [d setValue:username forKey:@"username"];
    [m POST:@"api/authenticate" parameters:d progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* d = (NSDictionary*) responseObject;
        NSString* token = [d valueForKey:@"token"];
        [SM setToken:token];
        [RM setAuthenticated:YES];
        [RequestManager setToken];
        [m GET:@"api/accountdetails" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            User* u = [User loginUser:(NSDictionary*)responseObject];
            if(u)
            {
                u.loggedIn = [NSNumber numberWithBool:YES];
                [DB save];
                [SM setCurrentUser:u];
                if(self.delegateLogin != nil && [self.delegateLogin respondsToSelector:@selector(onLoginResponse:result:error:)])
                {
                    [self.delegateLogin onLoginResponse:YES result:d error:nil];
                }
            }
            else
            {
                [SM resetLoginData];
                [SM setToken:nil];
                [RM setAuthenticated:NO];
                [SM setCurrentUser:nil];
                if(self.delegateLogin != nil && [self.delegateLogin respondsToSelector:@selector(onLoginResponse:result:error:)])
                {
                    [self.delegateLogin onLoginResponse:NO result:nil error:nil];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SM resetLoginData];
            [SM setToken:nil];
            [RM setAuthenticated:NO];
            [SM setCurrentUser:nil];
            if(self.delegateLogin != nil && [self.delegateLogin respondsToSelector:@selector(onLoginResponse:result:error:)])
            {
                
                [self.delegateLogin onLoginResponse:NO result:nil error:error];
            }
        }];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SM resetLoginData];
        [SM setToken:nil];
        [RM setAuthenticated:NO];
        [SM setCurrentUser:nil];
        if(self.delegateLogin != nil && [self.delegateLogin respondsToSelector:@selector(onLoginResponse:result:error:)])
        {
            [self.delegateLogin onLoginResponse:NO result:nil error:error];
        }
    }];
    
}


@end
