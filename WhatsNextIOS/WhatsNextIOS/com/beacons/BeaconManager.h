//
//  BeaconManager.h
//  WhatsNextIOS
//
//  Created by dragos on 5/17/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeaconNotificationsManager.h"
#import "NearestBeaconManager.h"
#import "Beacon.h"
#import "Agenda.h"
#import "Attachment.h"
#import <CWStatusBarNotification/CWStatusBarNotification.h>
#import <QuickLook/QuickLook.h>

@protocol BeaconManagerDelegate <NSObject>
//dragos daca beacon e null, nu e nici un beacon in range. daca attachment != nil deschizi fisierul asta daca agenda != nil, deschizi agenda agenda
@optional
-(void) onBeaconUpdate:(Beacon*) beacon attachment:(Attachment*)attachment agenda:(Agenda*) agenda;

@end

@interface BeaconManager : NSObject <NearestBeaconManagerDelegate,UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property(nonatomic, retain) NSString* lastId;

//dragos ca sa pornesti beaconsii apelezi APP.beaconManager registerBeacons si ii setezi delegatul cu APP.beaconManager.delegate = ce vrei tu.
@property(nonatomic, retain) NSURL* currentFileUrl;
@property(nonatomic, readwrite) BOOL isPreviewing;
@property(nonatomic,retain) QLPreviewController *previewController;
@property(nonatomic, retain) id<BeaconManagerDelegate> delegate;
@property(nonatomic, retain) CWStatusBarNotification* notif;
@property(nonatomic, retain) UIDocumentInteractionController* documentInteractionController;
-(void) showAgendaNotification:(Agenda*) a beacon:(Beacon*) b;
-(void) showAttachmentNotification:(Attachment*) a beacon:(Beacon*) b;
-(void) registerBeacons;
-(void) start;
-(void) stop;

-(void) openAttachment:(Attachment*) a;

-(void) openAgenda:(Agenda*) a;

@end
