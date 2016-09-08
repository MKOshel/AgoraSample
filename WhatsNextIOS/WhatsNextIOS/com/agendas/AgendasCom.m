//
//  AgendasCom.m
//  WhatsNextIOS
//
//  Created by dragos on 5/10/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "AgendasCom.h"
#import "Location.h"
#import "Beacon.h"
#import "Agenda.h"
#import "Attachment.h"
#import "FileDownloader.h"
#import "BeaconManager.h"

@implementation AgendasCom

-(void) getLocations:(long)eventId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/location",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arr = (NSArray*) responseObject;
        [Location parseLocations:arr eventId:eventId];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onLocationsReceived:eventId:error:)])
           [self.delegate onLocationsReceived:YES eventId:eventId error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onLocationsReceived:eventId:error:)])
            [self.delegate onLocationsReceived:NO eventId:eventId error:error];
    }];
}


-(void) downloadFiles:(long) eventId{
    Event* e = [Event getEvent:eventId];
    NSArray* arr = [e.attachments allObjects];
    long c = [arr count];
    for(int i = 0 ; i < [arr count] ; i++)
    {
        Attachment* a = [arr objectAtIndex:i];
        [FileDownloader downloadFile:a];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onDownloadFile:step:fileName:)])
            [self.delegate onDownloadFile:c step:i fileName:a.blobName];
    }
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onDownloadFilesComplete:eventId:)])
    {
        [self.delegate onDownloadFilesComplete:YES eventId:eventId];
    }
}

-(void) getFiles:(long) eventId
{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/files",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arr = (NSArray*) responseObject;
        [Attachment parseAttachments:arr eventId:eventId];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onFilesReceived:eventId:error:)])
            [self.delegate onFilesReceived:YES eventId:eventId error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onLocationsReceived:eventId:error:)])
            [self.delegate onFilesReceived:NO eventId:eventId error:error];
    }];
}

-(void) getParticipants:(long)eventId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/participants",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arr = (NSArray*) responseObject;
        [User parseParticipants:arr eventId:eventId];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onParticipantsReceived:eventId:error:)])
        {
            [self.delegate onParticipantsReceived:YES eventId:eventId error:nil ];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onParticipantsReceived:eventId:error:)])
        {
            [self.delegate onParticipantsReceived:NO  eventId:eventId error:error];
        }
    }];

}


-(void) getAllAgendas:(long)eventId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/schedule",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray* arr = (NSArray*) responseObject;
        Event* e = [Event getEvent:eventId];
        if(e == nil)
            [self.delegate onAllAgendasReceived:NO eventId:eventId error:nil];
        
        [Agenda parseAgendas:arr forEvent:e];
        if(self.delegate && [self.delegate respondsToSelector:@selector(onAllAgendasReceived:eventId:error:)])
        {
            [self.delegate onAllAgendasReceived:YES eventId:eventId error:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(onAllAgendasReceived:eventId:error:)])
        {
            [self.delegate onAllAgendasReceived:NO eventId:eventId error:error];
        }
    }];
}

-(void) getMyAgendas:(long) eventId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/scheduleparticipant",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arr = (NSArray*) responseObject;
        [Agenda parseMyAgendas:arr];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onMyAgendasReceived:eventId:error:)])
        {
            [self.delegate onMyAgendasReceived:YES eventId:eventId error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onMyAgendasReceived:eventId:error:)])
        {
            [self.delegate onMyAgendasReceived:NO eventId:eventId error:error];
        }
    }];
}

-(void) getMandatoryAgendas:(long) eventId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/schedulemparticipant",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arr = (NSArray*) responseObject;
        [Agenda parseMandatoryAgendas:arr];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onMandatoryAgendasReceived:eventId:error:)])
        {
            [self.delegate onMandatoryAgendasReceived:YES eventId:eventId error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onMandatoryAgendasReceived:eventId:error:)])
        {
            [self.delegate onMandatoryAgendasReceived:NO eventId:eventId error:error];
        }
    }];
}

-(void) joinAgenda:(long)agendaId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/joinsession/%ld",agendaId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onJoinedAgenda:agendaId:error:)])
        {
            [self.delegate onJoinedAgenda:YES agendaId:agendaId error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onJoinedAgenda:agendaId:error:)])
        {
            [self.delegate onJoinedAgenda:NO agendaId:agendaId error:error];
        }
        
    }];

}

-(void) unjoinAgenda:(long)agendaId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/removesession/%ld",agendaId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onUnJoinedAgenda:agendaId:error:)])
        {
            [self.delegate onUnJoinedAgenda:YES agendaId:agendaId error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onUnJoinedAgenda:agendaId:error:)])
        {
            [self.delegate onUnJoinedAgenda:NO agendaId:agendaId error:error];
        }
        
    }];
    
}

-(void) getOrganizers:(long)eventId{
    
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/organizers/%ld",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arr = (NSArray*) responseObject;
        [User parseOrganizers:arr eventId:eventId];
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onOrganizersReceived:eventId:error:)])
        {
            [self.delegate onOrganizersReceived:YES eventId:eventId error:nil];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onOrganizersReceived:eventId:error:)])
        {
            [self.delegate onOrganizersReceived:NO eventId:eventId error:error];
        }
        
    }];
}

-(void) getBeacons:(long)eventId{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/%ld/beacons",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray* arr = (NSArray*) responseObject;
        [Beacon parseBeacons:arr eventId:eventId];
        
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onBeaconsReceived:eventId:error:)])
        {
            [self.delegate onBeaconsReceived:YES eventId:eventId error:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onBeaconsReceived:eventId:error:)])
        {
            [self.delegate onBeaconsReceived:NO eventId:eventId error:error];
        }
    }];
}

@end
