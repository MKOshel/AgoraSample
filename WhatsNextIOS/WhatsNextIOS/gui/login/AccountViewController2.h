//
//  AccountViewController2.h
//  WhatsNextIOS
//
//  Created by dragos on 5/22/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MIResizableTableView.h"
#import "User.h"
#import "UserData.h"

@interface AccountViewController2 : BaseViewController<MIResizableTableViewDataSource,MIResizableTableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet MIResizableTableView *tableView;
@property(nonatomic,retain) User* user;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;
@property (nonatomic, retain)UserData* data;
@end
