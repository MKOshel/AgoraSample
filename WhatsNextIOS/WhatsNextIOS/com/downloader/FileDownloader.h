//
//  FileDownloader.h
//  WhatsNextIOS
//
//  Created by dragos on 5/13/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RequestManager.h"
#import "Attachment.h"

@interface FileDownloader : RequestManager

+(BOOL) downloadFile:(Attachment*) a;
+(NSURL*) getFileUrl:(Attachment*) a;
+(NSString*) getDocumentsPath;

@end
