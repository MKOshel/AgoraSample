//
//  EventsViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "BaseViewController.h"
#import "EventsCom.h"

@interface EventsViewController :BaseViewController <SlideNavigationControllerDelegate,EventsComDelegate,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageBack;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain) NSMutableArray* events;
@property(nonatomic, retain) NSMutableArray* filteredEvents;
@end
