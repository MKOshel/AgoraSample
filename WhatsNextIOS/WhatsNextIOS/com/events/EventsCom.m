//
//  EventsCom.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//
#import "AppDelegate.h"
#import "EventsCom.h"
#import "EventParser.h"
#import "Location.h"
#import "Agenda.h"
#import "BeaconManager.h"

@implementation EventsCom

-(void) getEvents{
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    [m GET:@"api/events" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* arrEvents = (NSArray*) responseObject;
        NSMutableArray* resp = [EventParser parseEvents:arrEvents];
        
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onEventsReceived:response:error:)])
        {
            [self.delegate onEventsReceived:YES response:resp error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onEventsReceived:response:error:)])
        {
            [self.delegate onEventsReceived:NO response:nil error:error];
        }

    }];
}



-(void) getEventData:(long)eventId{
    _req = [[AgendasCom alloc] init];
    _req.delegate = self;
    [_req getOrganizers:eventId];
}
//1
-(void) onOrganizersReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onOrganizersReceived:eventId:error:)])
            [self.downloadDelegate onOrganizersReceived:YES eventId:eventId error:nil];
        [_req getParticipants:eventId];
    }
    else
    {
        [self callError:eventId error:err];
    }
}
//2
-(void) onParticipantsReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onParticipantsReceived:eventId:error:)])
            [self.downloadDelegate onParticipantsReceived:YES eventId:eventId error:nil];

        [_req getLocations:eventId];
    }
    else{
        [self callError:eventId error:err];
    }
}
//3
-(void) onLocationsReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
   if(success)
   {
       if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onLocationsReceived:eventId:error:)])
           [self.downloadDelegate onLocationsReceived:YES eventId:eventId error:nil];

       [_req getAllAgendas:eventId];
   }
   else{
       [self callError:eventId error:err];
   }
}

//4
-(void) onAllAgendasReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onAllAgendasReceived:eventId:error:)])
            [self.downloadDelegate onAllAgendasReceived:YES eventId:eventId error:nil];
        
        if(![RM isAuthenticated])
            [_req getBeacons:eventId];
        else
            [_req getMyAgendas:eventId];
    }
    else{
       [self callError:eventId error:err];
    }
}

-(void) onMyAgendasReceived:(BOOL)success eventId:(long)eventId error:(NSError *)error
{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onMyAgendasReceived:eventId:error:)])
            [self.downloadDelegate onMyAgendasReceived:YES eventId:eventId error:nil];
        [_req getMandatoryAgendas:eventId];
    }
    else{
        [self callError:eventId error:error];
    }
}

-(void) onMandatoryAgendasReceived:(BOOL)success eventId:(long)eventId error:(NSError *)error
{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onMandatoryAgendasReceived:eventId:error:)])
            [self.downloadDelegate onMandatoryAgendasReceived:YES eventId:eventId error:nil];
        [_req getBeacons:eventId];
    }
    else{
        [self callError:eventId error:error];
    }
}

//5
-(void) onBeaconsReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err
{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onBeaconsReceived:eventId:error:)])
            [self.downloadDelegate onBeaconsReceived:YES eventId:eventId error:nil];

        [_req getFiles:eventId];
    }
    else
    {
        [self callError:eventId error:err];
    }
}
//6
-(void) onFilesReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
    if(success)
    {
        if(self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(onFilesReceived:eventId:error:)])
            [self.downloadDelegate onFilesReceived:YES eventId:eventId error:nil];

        [DB save];
        [_req downloadFiles:eventId];
    }
    else
    {
        [self callError:eventId error:err];
    }
}

-(void) onDownloadFile:(int)total step:(int)step fileName:(NSString *)fileName{
    if(self.downloadDelegate != nil && [self.downloadDelegate respondsToSelector:@selector(onDownloadFile:step:fileName:)])
        [self.downloadDelegate onDownloadFile:total step:step fileName:fileName];
}

-(void) onDownloadFilesComplete:(BOOL)success eventId:(long)eventId{
    if(success)
    {
        [APP.beaconManager registerBeacons];
        [self callSuccesss:eventId];
    }
    else
        [self callError:eventId error:nil];
}


-(void) callSuccesss:(long) eventId{
    //[APP.beaconManager registerBeacons];
    //[APP.beaconManager start];
    if(self.delegate && [self.delegate respondsToSelector:@selector(onEventDataReceived:response:error:)])
    {
        [self.delegate onEventDataReceived:YES response:eventId error:nil];
    }
}

-(void) callError:(long) eventId error:(NSError*) error{
    [APP.beaconManager start];
    if(self.delegate && [self.delegate respondsToSelector:@selector(onEventDataReceived:response:error:)])
    {
        [self.delegate onEventDataReceived:NO response:eventId error:error];
    }
    
}

-(void) selectEvent:(long) eventId{
    
    AFHTTPSessionManager* m = [RequestManager getManager];
    [RequestManager setToken];
    NSString* req = [NSString stringWithFormat:@"api/events/select/%ld",eventId];
    [m GET:req parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onSelectEvent:response:error:)])
        {
            [self.delegate onSelectEvent:YES response:eventId error:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onSelectEvent:response:error:)])
        {
            [self.delegate onSelectEvent:NO response:0 error:error];
        }
        
    }];
}

@end
