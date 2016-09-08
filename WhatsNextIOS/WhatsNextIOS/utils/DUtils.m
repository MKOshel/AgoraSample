//
//  DUtils.m
//  WhatsNextIOS
//
//  Created by Oshel on 5/19/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "DUtils.h"

@implementation DUtils

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
        [dateFormatter setDateFormat:@"dd MMM"];
        return [dateFormatter stringFromDate:date ];
    }
}
@end
