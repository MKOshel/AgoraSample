//
//  RequestManager.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RequestManager.h"

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
    [m.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [m.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
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
        
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onLoginResponse:result:error:)])
        {
            [self.delegate onLoginResponse:YES result:d error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onLoginResponse:result:error:)])
        {
            [self.delegate onLoginResponse:NO result:nil error:error];
        }
    }];
    
}


@end
