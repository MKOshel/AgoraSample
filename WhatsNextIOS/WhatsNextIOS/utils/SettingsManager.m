//
//  SettingsManager.m
//  RoadVikings
//
//  Created by dragos on 3/7/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "SettingsManager.h"
#import "JSONModel.h"
#import "JSONModelLib.h"
#import "RdUtils.h"


static User* currentUser;
static Event* currentEvent;
@implementation SettingsManager


+(NSString*) getNotificationToken{
    return [SM getString:KEY_NOTIFICATION_TOKEN];
}

+(void) setNotificationToken:(NSString *)token{
    [SM setString:KEY_NOTIFICATION_TOKEN value:token];
}

+(void) setLoggedInUsername:(NSString *)username{
    [SM setString:KEY_USERNAME value:username];
}

+(void) setLoggedInPassword:(NSString *)password{
    [SM setString:KEY_PASSWORD value:password];
}

+(NSString*) getLoggedInUsername{
    return [SM getString:KEY_USERNAME];
}

+(NSString*) getLoggedInPassword{
    return [SM getString:KEY_PASSWORD];
}

+(void) setSelectedEvent:(Event*) event{
    /*if(event == nil && currentEvent != nil)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_EVENT_CHANGED object:nil];
    }
    else
    {
        if(currentEvent == nil && event != nil)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_EVENT_CHANGED object:nil];
        }
        else
        {
            if([currentEvent.unique longValue] != [event.unique longValue])
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_EVENT_CHANGED object:nil];
        }
    }*/
    
    currentEvent = event;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_EVENT_CHANGED object:nil];
}

+(BOOL) getBeaconsEnabled{
    return [SM getBool:KEY_BEACONS_ENABLED];
}

+(void) setBeaconsEnabled:(BOOL)enabled{
    [SM setBool:KEY_BEACONS_ENABLED value:enabled];
}

+(Event*) getCurrentEvent{
    return currentEvent;
}

+(long long) getMaxLogSize{
    /*int iSize = [InmaUtils getGlobalIntegerPref:KEY_PREFERENCE_MAX_LOG_SIZE];
    if(maxLogSize == 0)
    {
        
        if(iSize == 0)
        {
            [InmaUtils setGlobalIntPref:KEY_PREFERENCE_MAX_LOG_SIZE value:20];
            iSize = 20;
        }
    }*/
    int iSize = 20;
    
    return iSize*1024*1024;
}

+(NSString*) getDeviceId{
    NSString* deviceId = [SM getString:KEY_DEVICE_ID];
    if(deviceId == nil)
    {
        deviceId = [[NSUUID UUID] UUIDString];
        [SM setString:KEY_DEVICE_ID value:deviceId];
    }
    return deviceId;
}



+(void) setCurrentUser:(User*) user{
    currentUser = user;
}



+(User*) getCurrentUser{
    if(currentUser == nil)
        return nil;
    if(currentUser)
        return currentUser;
    User* u = [User getLoggedInUser];
    return u;
}

+(void) setLoggedUserLogin:(NSString *)login
{
    [SM setString:KEY_USER_LOGGED_ID value:login];
}

+(NSString*) getLoggedUserLogin{
    return [SM getString:KEY_USER_LOGGED_ID];
}


+(void) setLastEOTTimestamp:(long)timestamp{
    [SM setLong:KEY_LAST_EOT_TIMESTAMP value:timestamp];
}

+(long) getLastEOTTimestamp{
    return [SM getLong:KEY_LAST_EOT_TIMESTAMP];
}

+(void) setString:(NSString*) key value:(NSString*) value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value
                     forKey:key];
    [userDefaults synchronize];
}

+(void) setBool:(NSString*) key value:(BOOL) value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[NSNumber numberWithBool:value]
                     forKey:key];
    [userDefaults synchronize];
}

+(BOOL) getBool:(NSString*) key{
      NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber* obj = [userDefaults objectForKey:key];
    if(obj)
        return [obj boolValue];
    return NO;
}

+(void) setRecording:(BOOL) recording{
    [SM setBool:KEY_RECORDING value:recording];
}

+(NSString*) getToken{
    return [SM getString:KEY_TOKEN];
}

+(void) setToken:(NSString*) token{
    [SM setString:KEY_TOKEN value:token];
}

+(void) resetLoginData{
    currentUser = nil;
    [SettingsManager setString:KEY_PASSWORD value:nil];
    [SettingsManager setString:KEY_REFRESH_TOKEN value:nil];
    [SettingsManager setString:KEY_TOKEN value:nil];
    [SettingsManager setString:KEY_USERNAME value:nil];    
}

+(long) getLong:(NSString*) key{
    NSNumber* str = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [str longValue];
}

+(BOOL) isRecording{
    return [SM getBool:KEY_RECORDING];
}

+(void) setLong:(NSString*) key value:(long) value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[NSNumber numberWithLong:value]
                     forKey:key];
    [userDefaults synchronize];
}


+(NSString*) getCurrentTripId{
    return [SM getString:KEY_CURRENT_TRIP_ID];
}

+(void) resetCurrentTripId{
    [SM setString:KEY_CURRENT_TRIP_ID value:[[NSUUID UUID] UUIDString]];
}

+(NSString*) getString:(NSString*) key{
    NSString* str = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return str;
}

+(void) setTripSeqNum:(long)value{
    [SettingsManager setLong:KEY_TRIP_SEQ_NUM value:value];
}

+(long) getTripSeqNum{
    return [SettingsManager getLong:KEY_TRIP_SEQ_NUM];
}

@end
