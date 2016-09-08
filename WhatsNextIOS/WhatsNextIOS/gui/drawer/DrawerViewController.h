//
//  DrawerViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "ViewController.h"

#import "SlideNavigationController.h"
#import "RequestManager.h"
#import "BaseViewController.h"


@interface DrawerViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LoginComDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentEvent;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;

@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@end
