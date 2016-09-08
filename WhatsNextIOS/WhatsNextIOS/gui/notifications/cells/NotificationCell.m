//
//  NotificationCell.m
//  WhatsNextIOS
//
//  Created by dragos on 5/19/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setNotification:(Notification *)n{
    _labelMessage.text = n.message;
    
    if([RU isToday:n.date])
    {
        _labelTime.text = [RU getTimeString:n.date];
    }
    else
        _labelTime.text = [RU getDayStringPrettyPrinted:n.date];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    /*if([n.read boolValue])
    {
        self.contentView.backgroundColor = RGB(blue_back);
    }
    else
        self.contentView.backgroundColor = RGB(unread_back);
    self.contentView.backgroundColor = RGB(blue_back);*/
}

@end
