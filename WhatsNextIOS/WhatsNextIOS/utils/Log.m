// file Log.m
#import "Log.h"
#import "NSData+CocoaDevUsersAdditions.h"
#import "SettingsManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "InmaUtils.h"

#define LOG_FILE @"logfile.txt"

@implementation Log

+(NSString*) getLogDate{
    NSDate* date = [NSDate date];
    if(date == nil)
        return @"";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* ret = [df stringFromDate:date];
    return [NSString stringWithFormat:@"[%@]",ret];
}



void append(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:LOG_FILE];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        fprintf(stderr,"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    }
    // append
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
}

void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    NSString* strLog = [NSString stringWithFormat:@"%@%@%@:%3d - %@",[Log getLogDate],prefix,[NSString stringWithUTF8String:funcName],lineNumber,msg];
    
    append(strLog);
    va_end (ap);
    fprintf(stderr,"%s%s%50s:%3d - %s",[[Log getLogDate] UTF8String],[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
}

+(NSNumber*) logSize{
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:LOG_FILE];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        fprintf(stderr,"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    }
    
    long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil][NSFileSize] longLongValue];
    return [[NSNumber alloc] initWithLongLong:fileSize];
}

+(void) resetLog{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:LOG_FILE];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        return;
    }
    NSFileHandle *file;
    
    file = [NSFileHandle fileHandleForUpdatingAtPath: path];
    
    if (file == nil)
        NSLog(@"Failed to open file");
    [file truncateFileAtOffset: 0];
    [file closeFile];
}

+(BOOL) setMaxSize{
    NSNumber* nSize = [Log logSize];
    long long size = [nSize longLongValue];
    if(size < [SettingsManager getMaxLogSize])
    {
        return YES;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:LOG_FILE];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        return NO;
    }
    
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@1",LOG_FILE]];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path2]){
        fprintf(stderr,"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    }
    NSUInteger chunkSize = 100 * 1024;
    uint8_t *buffer = malloc(chunkSize * sizeof(uint8_t));
    
    long long iDiff = size - [SettingsManager getMaxLogSize];
    
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath: path];
    if(file == nil) {
        return YES;
    }
    NSFileHandle *file2 = [NSFileHandle fileHandleForWritingAtPath: path2];
    if(file2 == nil) {
        return YES;
    }
    
    NSUInteger offset = 0;
    NSData* bytesCopied;
    do {
        [file seekToFileOffset:iDiff];
        bytesCopied = [file readDataOfLength:chunkSize];
        offset += [bytesCopied length];
        [file2 writeData:bytesCopied];
    } while (bytesCopied);
    [file closeFile];
    [file2 closeFile];
    NSError* err;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
    [[NSFileManager defaultManager] moveItemAtPath:path2 toPath:path error:&err];
    buffer = NULL;
    return YES;
}

+(NSData*) getArchivedLog{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:LOG_FILE];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        return  nil;
    }
    
    NSData* d = [[NSData alloc] initWithContentsOfFile:path];
    //return d;
    return [d gzipDeflate];
}
@end