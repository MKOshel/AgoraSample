//
//  RdUtils.m
//  RoadVikings
//
//  Created by dragos on 3/14/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RdUtils.h"
#import "AFNetworkReachabilityManager.h"
#import <sys/utsname.h>
#import "HDNotificationView.h"
#import <CWStatusBarNotification/CWStatusBarNotification.h>

static BOOL hasInternet = false;
static CWStatusBarNotification* notif = nil;
@implementation RdUtils


+(NSString*) gs:(NSObject*) obj{
    if(obj == nil)
        return nil;
    if([obj isKindOfClass:[NSNull class]])
        return nil;
    return (NSString*) obj;
}


+(NSNumber*) gb:(NSObject*) obj
{
    if(obj == nil)
        return nil;
    if([obj isKindOfClass:[NSNull class]])
        return nil;
    NSNumber* n = (NSNumber*) obj;
    return [NSNumber numberWithBool:[n boolValue]];
}


+(NSNumber*) gn:(NSObject*) obj{
    if(obj == nil)
        return nil;
    if([obj isKindOfClass:[NSNull class]])
        return nil;
    return (NSNumber*) obj;
    
}


+(BOOL) isToday:(NSDate*) d
{
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:d];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return YES;
    }
    return NO;
}


+(NSDate*) gd:(NSObject*) obj{
    if(obj == nil)
        return nil;
    if([obj isKindOfClass:[NSNull class]])
        return nil;
    NSString* str = (NSString*) obj;
    return [self parseDate:str];
}

+(void) showError:(UIViewController*) controller errorString:(NSString*) error{
    [RdUtils showRedError:controller errorString:error];
    return;
    if(!notif)
        notif = [[CWStatusBarNotification alloc] init];
    notif.notificationStyle = CWNotificationStyleStatusBarNotification;
    [notif displayNotificationWithMessage:error forDuration:2.0f];
    
    //[RU displayAlert:controller alert:error ok:@"ok" title:@"error"];
}

+(void) showRedError:(UIViewController*) controller errorString:(NSString*) error{
    if(!notif)
        notif = [[CWStatusBarNotification alloc] init];
    notif.notificationAnimationType = CWNotificationAnimationTypeOverlay;
    notif.notificationAnimationInStyle = CWNotificationAnimationStyleBottom;
    notif.notificationStyle = CWNotificationStyleStatusBarNotification;
    notif.notificationLabelBackgroundColor = RGB(red500);
    notif.notificationLabelTextColor = [UIColor whiteColor];
    [notif displayNotificationWithMessage:error forDuration:2.0f];
    //[RU displayAlert:controller alert:error ok:@"ok" title:@"error"];
}



+(void) showBeaconNotification:(NSString*) text Agenda:(Agenda*) agendaId fileId:(long) fileId handler:(void (^)(void))completion{
    if(!notif)
        notif = [[CWStatusBarNotification alloc] init];
    notif.notificationAnimationType = CWNotificationAnimationTypeOverlay;
    notif.notificationAnimationInStyle = CWNotificationAnimationStyleBottom;
    notif.notificationStyle = CWNotificationStyleStatusBarNotification;
    notif.notificationLabelBackgroundColor = RGB(blue700);
    notif.notificationLabelTextColor = [UIColor whiteColor];
    [notif displayNotificationWithMessage:text completion:^{
        [completion invoke];
    }];

    
    
}

+(void) showNotification:(UIViewController*) controller message:(NSString*)message{
    [RU displayAlert:controller alert:message ok:@"ok" title:@""];
}


+(NSDate*) substractWeeks:(NSDate*) d nrWeeks:(int)nrWeeks{
    NSDate *daysAgo = [d dateByAddingTimeInterval:-nrWeeks*7*24*60*60];
    return daysAgo;
}
+(NSDate*) getMonday:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitWeekOfYear fromDate:date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setWeekOfYear:[components weekOfYear]];
    [comps setWeekday:2];
    [comps setMinute:0];
    [comps setSecond:0];
    [comps setHour:0];
    [comps setYear:[components year]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //[calendar setFirstWeekday:2]; //This needs to be checked, which day is monday?
    NSDate *ret = [calendar dateFromComponents:comps];
    return ret;
}



+(NSDate*) getLastDayOfWeek:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitWeekOfYear fromDate:date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setWeekOfYear:[components weekOfYear]+1];
    [comps setWeekday:1];
    [comps setMinute:59];
    [comps setSecond:59];
    [comps setHour:23];
    [comps setYear:[components year]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //[calendar setFirstWeekday:2]; //This needs to be checked, which day is monday?
    NSDate *ret = [calendar dateFromComponents:comps];
    return ret;
}

+(BOOL) isValidEmail:(NSString *)checkString
{
    //return YES;
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(void) displayAlert:(UIViewController*) viewController alert:(NSString*) string ok:(NSString*) ok title:(NSString*) title{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, nil)
                                                                   message:NSLocalizedString(string, nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(ok,nil) style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                          }];
    
    [alert addAction:defaultAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}


+(void) displayAlertWithCompletition:(UIViewController*) viewController alert:(NSString*) string ok:(NSString*) ok title:(NSString*) title onOk:(void (^)(void))callbackBlock{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, nil)
                                                                   message:NSLocalizedString(string, nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(ok,nil) style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              callbackBlock();
                                                          }];
    
    [alert addAction:defaultAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+(NSString*) getJsonString:(NSDictionary*) dict{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(void) printDate:(NSDate *)date{
    if(date == nil)
    {
        NSLog(@"DATE : %@",@"NULL");
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
        NSLog(@"%@",[dateFormatter stringFromDate:date ]);
    }
}

+(NSString*) getDateString:(NSDate *)date{
    if(date == nil)
    {
        NSLog(@"DATE : %@",@"NULL");
        return @"NULL";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
        return [dateFormatter stringFromDate:date ];
    }
}

+(NSString*) getDayString:(NSDate *)date{
    if(date == nil)
    {
        NSLog(@"DATE : %@",@"NULL");
        return @"NULL";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        return [dateFormatter stringFromDate:date ];
    }
}


+(NSString*) getDayStringPrettyPrinted:(NSDate*)date // like 13 may 2016
{
    if(date == nil)
    {
        NSLog(@"DATE : %@",@"NULL");
        return @"NULL";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"ro_RO"];
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
        [dateFormatter setDateFormat:@"EEEE dd MMMM"];
        return [dateFormatter stringFromDate:date ];
    }
}

+(NSString*) getDayStringSlash:(NSDate *)date{
    if(date == nil)
    {
        NSLog(@"DATE : %@",@"NULL");
        return @"NULL";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        return [dateFormatter stringFromDate:date ];
    }
}



+(void) logMessage:(NSString *)str{
    NSLog(@"%@",str);
}

+(NSString*) getString:(NSDictionary*) d key:(NSString*) key
{
    
    id obj = [d valueForKey:key];
    if([obj class] == [NSNull class])
    {
        return nil;
    }
    return (NSString*) obj;
}

+(NSNumber*) getCurrentTime{
    long time = [[NSDate date] timeIntervalSince1970];
    return [NSNumber numberWithLong:time];
}


+(NSNumber*) getLong:(NSDictionary*) d key:(NSString*) key{
    id obj = [d valueForKey:key];
    if([obj class] == [NSNull class])
    {
        return [NSNumber numberWithLong:0L];
    }
    return [NSNumber numberWithLong:[[d objectForKey:key] longValue]];
}

+(NSNumber*) getDouble:(NSDictionary*) d key:(NSString*) key{
    id obj = [d valueForKey:key];
    if([obj class] == [NSNull class])
    {
        return [NSNumber numberWithDouble:0.0];;
    }
    return [NSNumber numberWithDouble:[[d objectForKey:key] doubleValue]];
}

+(NSString*) formatShortDate:(NSDate *)date{
    if(date == nil)
        return @"";

    @try {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;
        df.timeStyle = NSDateFormatterNoStyle;
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSString* ret =  [NSString stringWithFormat:@"%@", [df stringFromDate:date]];
        return ret;
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    } @finally {
        
    }
}

+(void) logError:(NSError *)e{
    NSLog(@"%@",e.description);
}

+(void) logException:(NSException *)e{
    NSLog(@"%@",e.description);
}

+(UIImage*) imageFromUrl:(NSString*) url{
    NSString *ImageURL = url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    if(imageData == nil)
        return nil;
    return [UIImage imageWithData:imageData];
}

+(NSString*) formatDateAll:(NSDate*) date{
    if(date == nil)
        return @"";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [df stringFromDate:date];
}


+(NSString*) getIosVersion{
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    return ver;
}

+(NSString*) getPhoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString* str = [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
    return str;
}

+(NSString*) getAppVersion{
    NSString* ret = [NSString stringWithFormat:@"Version: %@ (%@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    return ret;
}

+(void) treatError:(NSError *)error viewController:(UIViewController *)vc{
    if(error == nil)
        return ;
    //[ServerResponse treatError:error viewController:vc];
}

+(BOOL) hasInternet{
    return hasInternet;
}

+(NSDate*) getTime:(long long) timeInMilis{
    NSDate* d = [NSDate dateWithTimeIntervalSince1970:timeInMilis/1000];
    return d;
}

+(NSDate*) parseDate:(NSString *)strDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate* ret = [dateFormatter dateFromString:strDate];
    return ret;
}

+(void) monitorReachability{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"Reachability changed: %@", AFStringFromNetworkReachabilityStatus(status));
        
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // -- Reachable -- //
                hasInternet = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                // -- Not reachable -- //
                hasInternet = NO;
                break;
        }
        
    }];
}

+(NSString*) getTimeString:(NSDate *)d{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:d];
    //return formattedDateString;
}


+(NSDictionary*) getDictionary:(NSString*) str{
    NSError* jsonError;
    NSDictionary* d = [NSJSONSerialization JSONObjectWithData:[ str dataUsingEncoding:NSUTF8StringEncoding]
                                    options:NSJSONReadingMutableContainers
                                      error:&jsonError];
    if(jsonError)
    {
        [RU logError:jsonError];
    }
    return d;
}

+(NSNumber*) getTime:(NSDictionary*) d key:(NSString*) key{
    id obj = [d valueForKey:key];
    if([obj class] == [NSNull class])
    {
        return [NSNumber numberWithLong:0L];;
    }
    long long l = [[d objectForKey:key] longLongValue];
    NSNumber* n =  [NSNumber numberWithLongLong:l];
    //long l1 = [n integerValue];
    return n;
}


@end
