//
//  Log.h
//  Inmarsat
//
//  Created by Andrei on 01/06/2013.
//
//

#import <Foundation/Foundation.h>
// file Log.h

///logging functions.
#define NSLog(args...) _Log(@"DEBUG ", __FILE__,__LINE__,__PRETTY_FUNCTION__,args);
@interface Log : NSObject
void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...);

+(NSNumber*) logSize;
+(NSData*) getArchivedLog;
+(void) resetLog;
+(BOOL) setMaxSize;
@end

