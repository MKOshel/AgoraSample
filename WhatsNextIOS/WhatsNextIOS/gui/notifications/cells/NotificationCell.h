//
//  NotificationCell.h
//  WhatsNextIOS
//
//  Created by dragos on 5/19/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification.h"

@interface NotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageNotification;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;
-(void) setNotification:(Notification*) n;

@end
