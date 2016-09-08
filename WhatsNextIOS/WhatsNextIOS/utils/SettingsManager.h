//
//  SettingsManager.h
//  RoadVikings
//
//  Created by dragos on 3/7/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "User.h"
#import "Event.h"


#define KEY_PASSWORD @"KEY_PASSWORD"
#define KEY_USERNAME @"KEY_USERNAME"
#define KEY_REFRESH_TOKEN @"KEY_REFRESH_TOKEN"
#define KEY_TOKEN @"KEY_TOKEN"
#define KEY_TRIP_SEQ_NUM @"KEY_SEQ_TRIP_NUM"
#define KEY_LAST_EOT_TIMESTAMP @"KEY_LAST_EOT_TIMESTAMP"
#define KEY_TRIP_STATE @"KEY_TRIP_STATE"
#define KEY_DEVICE_ID @"KEY_DEVICE_ID"
#define KEY_CURRENT_TRIP_ID @"KEY_CURRENT_TRIP_ID"
#define KEY_RECORDING @"KEY_RECORDING"
#define KEY_USER_LOGGED_ID @"KEY_USER_LOGGED_ID"
#define KEY_NOTIFICATION_TOKEN @"KEY_NOTIFICATION_TOKEN"
#define KEY_BEACONS_ENABLED @"KEY_NOTIFICATION_BEACONS_ENABLED"


@interface SettingsManager : NSObject

+(NSString*) getToken;

+(void) setToken:(NSString*) token;

+(void) setBeaconsEnabled:(BOOL) enabled;
+(BOOL) getBeaconsEnabled;
+(void) setLoggedInUsername:(NSString*) username;
+(void) setLoggedInPassword:(NSString*) password;
+(NSString*) getLoggedInPassword;
+(NSString*) getLoggedInUsername;
+(void) setSelectedEvent:(Event*) event;
+(Event*) getCurrentEvent;
+(long long) getMaxLogSize;
+(void) setLoggedUserLogin:(NSString*) login;
+(NSString*) getLoggedUserLogin;
+(BOOL) isRecording;
+(void) setRecording:(BOOL) recording;
+(BOOL) getBool:(NSString*) key;
+(NSString*) getCurrentTripId;
+(void) resetCurrentTripId;
+(NSString*) getDeviceId;
+(void) resetLoginData;
+(User*) getCurrentUser;
+(void) setCurrentUser:(User*) user;
+(NSString*) getString:(NSString*) key;
+(void) setString:(NSString*) key value:(NSString*) value;

+(void) setNotificationToken:(NSString*) token;
+(NSString*) getNotificationToken;

+(void) setTripSeqNum:(long) value;
+(long) getTripSeqNum;

+(long) getLong:(NSString*) key;
+(void) setLong:(NSString*) key value:(long) value;

+(long) getLastEOTTimestamp;
+(void) setLastEOTTimestamp:(long) timestamp;



@end
