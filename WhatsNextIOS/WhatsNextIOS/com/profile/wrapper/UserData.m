//
//  UserData.m
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "UserData.h"

@implementation UserData


-(id) init{
    if(self = [super init])
    {
        _username = @"";
        _password = @"";
        _lastName = @"";
        _firstName = @"";
        _title = @"Dr";
        _jobTitle = @"";
        _phone = @"";
        _email = @"";
        _langKey = @"ro";
    }
    return self;
}

-(NSString*) checkEmail{
    if([RU isValidEmail:_email])
    {
        return nil;
    }
    return @"email invalid";
}

-(NSString*) checkUsername{
    if(_username.length < 5)
    {
        return @"username trebuie sa aiba minim 5 caractere";
    }
    return nil;
}

-(NSString*) checkpassword1{
    if(_password.length < 5)
    {
        return @"parola trebuie sa aiba minim 5 caractere";
    }
    return nil;
}


-(NSString*) checkPassword2{
    if(![_password2 isEqualToString:_password])
        return @"parolele nu corespund";
    return nil;
}


@end
