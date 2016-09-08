//
//  ScheduleViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/10/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "BaseViewController.h"
#import "Event.h"
#import "EventsCom.h"
#import "SlideNavigationController.h"
#import "AgendasCom.h"
#import "TVAgendaCell.h"

@interface ScheduleViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,EventsComDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SlideNavigationControllerDelegate,AgendasComDelegate,AgendaCellDelegate>

@property(nonatomic, retain) Event * event;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSchedule;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewDays;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain)  EventsCom* req;
@property(nonatomic, readwrite) NSInteger row;

@property(nonatomic, retain) NSMutableArray* days;
@end
