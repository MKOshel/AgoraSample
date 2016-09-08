//
//  AgendasCom.h
//  WhatsNextIOS
//
//  Created by dragos on 5/10/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RequestManager.h"

@protocol AgendasComDelegate <NSObject>

@optional
-(void) onLocationsReceived:(BOOL) success eventId:(long) eventId  error:(NSError*) err;
-(void) onBeaconsReceived:(BOOL) success eventId:(long) eventId error:(NSError*) err;
-(void) onOrganizersReceived:(BOOL) success eventId:(long) eventId error:(NSError*) err;
-(void) onParticipantsReceived:(BOOL) success eventId:(long) eventId error:(NSError*) err;
-(void) onAllAgendasReceived:(BOOL) success eventId:(long) eventId error:(NSError*) err;
-(void) onFilesReceived:(BOOL) success eventId:(long) eventId error:(NSError*) err;
-(void) onDownloadFile:(int) total step:(int) step fileName:(NSString*) fileName;
-(void) onDownloadFilesComplete:(BOOL) success eventId:(long) eventId;
-(void) onMyAgendasReceived:(BOOL) success eventId:(long) eventId error:(NSError*) error;
-(void) onMandatoryAgendasReceived:(BOOL) success eventId:(long) eventId error:(NSError*) error;
-(void) onJoinedAgenda:(BOOL) success agendaId:(long) agendaId error:(NSError*)e;
-(void) onUnJoinedAgenda:(BOOL) success agendaId:(long) agendaId error:(NSError*)e;
@end


@interface AgendasCom : RequestManager

@property(nonatomic, retain) id<AgendasComDelegate>  delegate;
-(void) getLocations:(long) eventId;
-(void) getBeacons:(long) eventId;
-(void) getOrganizers:(long) eventId;
-(void) getParticipants:(long) eventId;
-(void) getAllAgendas:(long) eventId;
-(void) getFiles:(long) eventId;
-(void) downloadFiles:(long) eventId;
-(void) getMandatoryAgendas:(long) eventId;
-(void) getMyAgendas:(long) eventId;
-(void) joinAgenda:(long) agendaId;
-(void) unjoinAgenda:(long) agendaId;

@end
