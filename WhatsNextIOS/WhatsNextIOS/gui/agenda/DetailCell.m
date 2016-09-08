//
//  DetailCell.m
//  WhatsNextIOS
//
//  Created by Dragos on 19/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.labelTime.textColor = RGB(yellow0);
    self.labelDescr.textColor = RGB(yellow0);
    self.labelSeatsNumber.textColor = RGB(yellow0);
    self.labelSpeakers.textColor = RGB(yellow0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
