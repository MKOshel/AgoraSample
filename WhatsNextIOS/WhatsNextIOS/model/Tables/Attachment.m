//
//  Attachment.m
//  
//
//  Created by dragos on 5/9/16.
//
//

#import "Attachment.h"
#import "Agenda.h"
#import "Beacon.h"
#import "Event.h"
#import "FileDownloader.h"

@implementation Attachment

// Insert code here to add functionality to your managed object subclass
+(void) parseAttachments:(NSArray *)arrAttachments eventId:(long) eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return;
    for(int i = 0 ; i < [arrAttachments count] ; i++)
    {
        NSDictionary* d = [arrAttachments objectAtIndex:i];
        Attachment* a= [Attachment parseAttachment:d];
        if( a != nil)
            a.event = e;
        
    }
    [DB save];
    
}

-(NSData*) getAttachmentData{
    if(self.localPath == nil)
        return nil;
    NSLog(@"%@",self.localPath);
    NSError* error;
    NSString* filePath = [self getRealFilePath];
    NSData *plistData = [NSData dataWithContentsOfFile:filePath options:0 error:&error];
    if(!plistData) {
        NSLog(@"failed to read data: %@",error);
        return nil;
    }
    return plistData;
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:self.localPath];
    return data;
}

-(void) deleteFile{
    if(self.localPath == nil)
        return;
    @try {
        NSError* err;
        [[NSFileManager defaultManager] removeItemAtPath:[self getRealFilePath] error:&err];
        if(err != nil){
            int i = 0;
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    } @finally {
    }
}

-(NSString*) getRealFilePath{
    NSString* realPath = [NSString stringWithFormat:@"%@/%@",[FileDownloader getDocumentsPath],self.localPath];
    return realPath;
}

+(NSArray*) getAttachmentsForEvent:(long)eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return nil;
    NSArray* arr = [Event MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"event.unique = %@",[NSNumber numberWithLong:eventId]]];
    return arr;
}

+(BOOL) deleteAttachmentsForPrivateEvents{
    return YES;
}


+(Attachment*) parseAttachment:(NSDictionary*) d{
    NSNumber* unique = [RU getLong:d key:@"id"];
    if(unique == nil)
        return nil;
    NSString* url = [RU getString:d key:@"url"];
    NSString* blobName = [RU getString:d key:@"blobName"];
    NSNumber* agendaId = [RU getLong:d key:@"agendaLink"];
    NSDictionary* dBeacon = [d objectForKey:@"beacon"];
    Beacon* b = nil;
    if(dBeacon != nil && [dBeacon class] == [NSDictionary class])
    {
        b = [Beacon parseBeacon:dBeacon];
    }
    Agenda* a = nil;
    if(agendaId != nil)
    {
        a = [Agenda getAgenda:[agendaId longValue]];
    }
    
    Attachment* file = [Attachment getAttachment:[unique longValue]];
    if(file == nil)
        file = [Attachment MR_createEntity];
    
    file.unique = unique;
    file.url = url;
    file.beacon = b;
    file.agenda = a;
    file.blobName = blobName;
    [DB save];
    NSArray* arr = [Attachment MR_findAll];
    return file;
}

+(Attachment*) getAttachment:(long) unique{
    return [Attachment MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unique = %ld",unique]];
}



@end
