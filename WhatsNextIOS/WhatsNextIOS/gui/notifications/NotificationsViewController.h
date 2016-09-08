//
//  NotificationsViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/19/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface NotificationsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SlideNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain) NSMutableArray* notifications;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@end
