//
//  ProfileCom.m
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "ProfileCom.h"

@implementation ProfileCom

-(void) registerProfile:(UserData*) data;
{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/register"];
    
    NSMutableDictionary* d = [[NSMutableDictionary alloc] init];
    
    [d setValue:data.username forKey:@"login"];
    [d setValue:data.password forKey:@"password"];
    
    
    if(data.email != nil)
       [d setValue:data.email forKey:@"email"];
    if(data.phone != nil)
        [d setValue:data.email forKey:@"phone"];
    if(data.lastName != nil)
        [d setValue:data.lastName forKey:@"lastName"];
    if(data.firstName != nil)
        [d setValue:data.firstName forKey:@"firstName"];

    if(data.jobTitle != nil)
        [d setValue:data.jobTitle forKey:@"jobTitle"];

    if(data.title != nil)
        [d setValue:data.title forKey:@"title"];
    
    
    [m POST:req parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onRegisterResult:error:)])
        {
            [self.delegate onRegisterResult:YES error:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onRegisterResult:error:)])
        {
            [self.delegate onRegisterResult:NO error:error];
        }
    }];
}

-(void) updateAccount:(UserData *)data{
    
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/updateprofile"];
    
    NSMutableDictionary* d = [[NSMutableDictionary alloc] init];

    if(data.phone != nil)
        [d setValue:data.email forKey:@"phone"];
    if(data.lastName != nil)
        [d setValue:data.lastName forKey:@"lastName"];
    if(data.firstName != nil)
        [d setValue:data.firstName forKey:@"firstName"];
    
    if(data.jobTitle != nil)
        [d setValue:data.jobTitle forKey:@"jobTitle"];
    
    if(data.title != nil)
        [d setValue:data.title forKey:@"title"];
    
    [m PUT:req parameters:data success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onAccountUpdate:error:)])
        {
            [self.delegate onAccountUpdate:YES error:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onAccountUpdate:error:)])
        {
            [self.delegate onAccountUpdate:NO error:error];
        }
    }];
    
}

@end
