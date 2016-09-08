//
//  RdUtils.h
//  RoadVikings
//
//  Created by dragos on 3/14/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RdUtils : NSObject

+(NSString*) getDayStringSlash:(NSDate *)date;
+(NSString*) getDayStringPrettyPrinted:(NSDate*)date;
+(NSDate*) getLastDayOfWeek:(NSDate *)date;
+(void) treatError:(NSError*) error viewController:(UIViewController*) vc;
+(NSString*) getString:(NSDictionary*) d key:(NSString*) key;
+(NSNumber*) getLong:(NSDictionary*) d key:(NSString*) key;
+(NSNumber*) getDouble:(NSDictionary*) d key:(NSString*) key;
+(NSNumber*) getTime:(NSDictionary*) d key:(NSString*) key;
+(void) printDate:(NSDate*) date;
+(NSString*) getDateString:(NSDate*) d;
+(NSString*) getJsonString:(NSDictionary*) dict;
+(void) showError:(UIViewController*) controller errorString:(NSString*) error;

+(BOOL) isToday:(NSDate*) d;

+(void) showNotification:(UIViewController*) controller message:(NSString*)message;
+(NSString*) gs:(NSObject*) obj;
+(NSNumber*) gn:(NSObject*) obj;
+(NSDate*) gd:(NSObject*) obj;
+(NSNumber*) gb:(NSObject*) obj;
+(void) showRedError:(UIViewController*) controller errorString:(NSString*) error;

+(NSDate*) parseDate:(NSString*) date;

+(NSString*) formatShortDate:(NSDate*) date;
+(UIImage*) imageFromUrl:(NSString*) url;

+(NSString*) getAppVersion;
+(NSString*) getPhoneType;
+(NSString*) getIosVersion;

+(NSDate*) getTime:(long long) timeInMilis;
+(NSString*) getDayString:(NSDate *)date;
+(NSString*) getTimeString:(NSDate*)d;
+(NSString*) formatDateAll:(NSDate*) date;

+(NSNumber*) getCurrentTime;
+(void) monitorReachability;
+(BOOL) isValidEmail:(NSString *)checkString;

+(BOOL) hasInternet;

+(NSDate*) getMonday:(NSDate*) date;
+(NSDate*) substractWeeks:(NSDate*) d nrWeeks:(int)nrWeeks;

+(void) logError:(NSError*) e;
+(void) logException:(NSException*) e;
+(NSDictionary*) getDictionary:(NSString*) str;
+(void) logMessage:(NSString*) str;
+(void) displayAlert:(UIViewController*) viewController alert:(NSString*) string ok:(NSString*) ok title:(NSString*) title;
+(void) displayAlertWithCompletition:(UIViewController*) viewController alert:(NSString*) string ok:(NSString*) ok title:(NSString*) title onOk:(void (^)(void))callbackBlock;
@end
