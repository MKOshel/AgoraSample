//
//  EventsCell.m
//  WhatsNextIOS
//
//  Created by Oshel on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "EventsCell.h"

@implementation EventsCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = RGB(yellow0);
    self.labelName.textColor = RGB(blue_back);
    self.labelAddress.textColor = RGB(blue_back);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
