//
//  FileDownloader.m
//  WhatsNextIOS
//
//  Created by dragos on 5/13/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "FileDownloader.h"

@implementation FileDownloader



+(NSString*) getDocumentsPath{
    NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    NSError* error;
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@",documentsDirectory] withIntermediateDirectories:YES attributes:nil error:&error ];
    return [NSString stringWithFormat:@"%@/Actions",documentsDirectory];
}

+(NSString*) getFileDbPath:(NSString*) name unique:(long) unique{
    return [NSString stringWithFormat:@"%ld/%@",unique,name];
}

+(NSString*) getFilePath:(NSString*) name unique:(long) unique{
    NSString  *filePath = [NSString stringWithFormat:@"%@/%ld", [FileDownloader getDocumentsPath],unique];
    NSError* error;
    [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error ];
    
    if(error != nil)
        return nil;
    return [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
}

+(NSString*) storeFile:(NSData*) data attachment:(Attachment*) a{
    if(data == nil)
        return nil;
    NSString* filePath = [FileDownloader getFilePath:a.blobName unique:[a.unique longValue]];
    

    BOOL b = [data writeToFile:filePath atomically:YES];
    
    if(b)
    {
        NSString* dbPath = [FileDownloader getFileDbPath:a.blobName unique:[a.unique longValue]];
        return dbPath;
    }
    return nil;
}

+(NSURL*) getFileUrl:(Attachment*) a{
    if(a.localPath == nil)
        return nil;
    NSURL* url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[FileDownloader getDocumentsPath],a.localPath]];
    return url;
}

+(BOOL) downloadFile:(Attachment*) a{
    NSString *stringURL = a.url;
    if(a.url == nil || [a.url isEqualToString:@""])
    {
        return NO;
    }
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSString* filePath = [FileDownloader storeFile:urlData attachment:a];
        a.localPath = filePath;
        [DB save];
        if(filePath)
            return YES;
        return NO;
    }
    else {
        return NO;
    }
}
@end
