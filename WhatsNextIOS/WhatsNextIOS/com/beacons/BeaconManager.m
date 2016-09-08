//
//  BeaconManager.m
//  WhatsNextIOS
//
//  Created by dragos on 5/17/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//
#import "AppDelegate.h"
#import "BeaconManager.h"
#import "Beacon.h"
#import "BeaconID.h"
#import "HDNotificationView.h"
#import "RdUtils.h"
#import "ScheduleDetailVC.h"
#import "SlideNavigationController.h"
#import "ParticipantsVC.h"
#import "Notification.h"


static NearestBeaconManager* bManager;

@implementation BeaconManager

-(id) init
{
    if(self = [super init])
    {
        _notif = [[CWStatusBarNotification alloc] init];
    }
    return self;
}

-(void) start{
    bManager.delegate = self;
    [bManager startNearestBeaconUpdates];
}

-(void) stop{
    [bManager stopNearestBeaconUpdates];
}

+(NearestBeaconManager*) getManager:(NSArray*) beacons{
    if(bManager == nil)
    {
        bManager = [[NearestBeaconManager alloc] initWithBeaconRegions:beacons];
        
    }
    
    return bManager;
}

-(void) showAgendaNotification:(Agenda*) a beacon:(Beacon*) b{
    NSString* message = [NSString stringWithFormat:@"Afla detalii despre agenda %@",a.name];
    long agendaId = [a.unique longValue];
    
    [Notification addNotification:b agenda:a attachment:nil title:@"Sesiune" message:[NSString stringWithFormat:@"Afla mai multe detalii despre sesiunea %@",a.name]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
    
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"ic_notifications_black.png"] title:a.name message:message isAutoHide:YES duration:5.0 onTouch:^{
        [HDNotificationView hideNotificationViewOnComplete:^{
            
        
        /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:[NSString stringWithFormat:@"Doriti sa aflati detalii despre sesiunea %@",a.name]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Afiseaza" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {*/
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        [self openAgenda:a];
                                                                        Notification* n = [Notification getNotification:b];
                                                                        if(n){
                                                                            n.read = [NSNumber numberWithBool:YES];
                                                                            [DB save];
                                                                        }
                                                                      
                                                                  
                                                                    });
                                                              }];
        /*UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Anuleaza" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              }];

        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        UIViewController* vc = [GuiUtils getTopViewController];
        [vc presentViewController:alert animated:YES completion:^{
            
        }];
        }];*/
        //[self presentViewController:alert animated:YES completion:nil];
    }];
}


-(void) openAttachment:(Attachment*) a{
    
    _isPreviewing = YES;
    NSURL *resourceToOpen = [NSURL fileURLWithPath:[a getRealFilePath]];
    _currentFileUrl = resourceToOpen;
    //UIViewController* top = [GuiUtils getTopViewController];
    
    UIViewController* top = [[SlideNavigationController sharedInstance].viewControllers lastObject];
    _previewController=[[QLPreviewController alloc]init];
    _previewController.delegate=APP.beaconManager;
    _previewController.dataSource = APP.beaconManager;
    [[UINavigationBar appearanceWhenContainedIn:[QLPreviewController class], nil]
     setTintColor:[UIColor blackColor]];
    [top presentModalViewController:_previewController animated:YES];
}

-(void) openAgenda:(Agenda*) a{
    UIViewController* top = [GuiUtils getTopViewController];
    
    
    UIViewController* actualVC = [[SlideNavigationController sharedInstance].viewControllers lastObject];
    
    ScheduleDetailVC* vc = (ScheduleDetailVC*)[GU getController:@"Events" identifier:@"ScheduleDetailVC"];
    vc.agenda = a;
    if(actualVC)
    {
        [actualVC.navigationController pushViewController:vc animated:YES];
    }

}

-(void) showAttachmentNotification:(Attachment*) a beacon:(Beacon*) b{
    //_isPreviewing = YES;
    NSString* message = [NSString stringWithFormat:@"Deschide fisierul %@",a.blobName];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
    
    [Notification addNotification:b agenda:nil attachment:a title:@"Sesiune" message:[NSString stringWithFormat:@"Deschide fisierul %@",a.blobName]];
    //a = [Attachment MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"blobName = %@",[NSString stringWithFormat:@"1.jpeg"]]];
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"ic_notifications_black.png"] title:a.blobName message:message isAutoHide:YES duration:5.0 onTouch:^{
        [HDNotificationView hideNotificationViewOnComplete:^{
            
            
            /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:[NSString stringWithFormat:@"Doriti sa deschideti fisierul %@?",a.blobName ]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Deschide" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {*/
                                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                                          
                                                                          
                                                                          /*self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:resourceToOpen];
                                                                          
                                                                          // Configure Document Interaction Controller
                                                                          [self.documentInteractionController setDelegate:self];
                                                                          // Present Open In Menu
                                                                          UIViewController* top = [GuiUtils getTopViewController];
                                                                          SlideNavigationController* ctrl = (SlideNavigationController*) top;
                                                                          //NSData* d = a
                                                                           [self.documentInteractionController presentOptionsMenuFromRect:ctrl.view.frame inView:ctrl.view animated:YES];
                                                                          BOOL canOpenResource = [[UIApplication sharedApplication] canOpenURL:resourceToOpen];
                                                                          if (canOpenResource) { [[UIApplication sharedApplication] openURL:resourceToOpen]; }
                                                                           */
                                                                          
                                                                          [self openAttachment:a];
                                                                          
                                                                          //[_previewController.navigationItem setRightBarButtonItem:nil];
                                                                          
                                                                      });
                                                                  }];
        /*
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Anuleaza" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     _isPreviewing = NO;
                                                                 }];
            
            
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            UIViewController* vc = [GuiUtils getTopViewController];
            [vc presentViewController:alert animated:YES completion:^{
                
            }]
        }];*/
        //[self presentViewController:alert animated:YES completion:nil];
    }];
}


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    if(_currentFileUrl == nil)
        return 0;
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return _currentFileUrl;
}

-(void) previewControllerDidDismiss:(QLPreviewController *)controller{
    _isPreviewing = NO;
}


-(void) nearestBeaconManager:(NearestBeaconManager *)nearestBeaconManager didUpdateNearestBeaconID:(BeaconID *)beaconID{
    if(_isPreviewing)
        return;
    
    if(beaconID == nil && _lastId != nil)
    {
        _lastId = nil;
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onBeaconUpdate:attachment:agenda:)])
        {
            [self.delegate onBeaconUpdate:nil attachment:nil agenda:nil];
        }
        return;
    }
    if(beaconID == nil)
        return;
    
    NSString* uuid = beaconID.proximityUUID.UUIDString;
    NSString* unique = [NSString stringWithFormat:@"%@:%d:%d",uuid,beaconID.major,beaconID.minor];
    if([unique isEqualToString:_lastId])
        return;
    //_lastId = unique;
    Beacon* b = [Beacon getBeacon:unique];
    if(b != nil)
    {
        Notification* n = [Notification getNotification:b];
        if(n != nil)
            return;
        
        
        //if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onBeaconUpdate:attachment:agenda:)])
        {
            if(b.fileId != nil && [b.fileId intValue]!= 0)
            {
                Attachment* a = [Attachment getAttachment:[b.fileId longValue]];
                if(a != nil)
                {
                    [self showAttachmentNotification:a beacon:b];
                }
                [self.delegate onBeaconUpdate:b attachment:a agenda:nil];
            }
            if(b.location != nil)
            {
                Agenda* a =[Agenda getCurrentAgendaForLocation:b.location];
                if(a != nil)
                {
                    NSLog(@"Detected : %@",a.name);
                    [self showAgendaNotification:a beacon:b];
                    //self.delegate onBeaconUpdate:b attachment:nil agenda:a];
                }
            }
        }
    }
    else
    {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onBeaconUpdate:attachment:agenda:)])
        {
            [self.delegate onBeaconUpdate:nil attachment:nil agenda:nil];
        }
    }
}


-(void) registerBeacons{
    [self stop];
    bManager = nil;
    NSArray* beacons = [Beacon MR_findAll];
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < [beacons count] ; i++)
    {
        Beacon* b = [beacons objectAtIndex:i];
        NSLog(@"uuid = %@",b.uuid);
        [arr addObject:[[BeaconID alloc] initWithUUIDString:b.uuid major:[b.major unsignedShortValue] minor:[b.minor unsignedShortValue]].asBeaconRegion];
        
    }
    if([arr count]){
        bManager = [BeaconManager getManager:arr];
        bManager.delegate = self;
        [self start];
    }
    else{
        if(bManager)
        {
            [bManager stopNearestBeaconUpdates];
            bManager = nil;
        }
    }
    
}

@end
