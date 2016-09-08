//
//  OrganizersVC.h
//  WhatsNextIOS
//
//  Created by Dragos on 18/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "BaseViewController.h"
#import "Event.h"
#import "EventsCom.h"
#import "MIResizableTableView.h"
#import "SlideNavigationController.h"

@interface OrganizersVC : BaseViewController< UITableViewDataSource,UITableViewDelegate,EventsComDelegate,SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageback;

@end
