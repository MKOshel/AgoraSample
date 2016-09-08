//
//  DrawerCell.h
//  WhatsNextIOS
//
//  Created by dragos on 5/10/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageDrawer;
@property (weak, nonatomic) IBOutlet UILabel *labelDrawer;
@property (weak, nonatomic) IBOutlet UILabel *labelNotifications;
-(void) setNumberOfNotifications:(long) notifications;
@end
