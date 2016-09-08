//
//  AttachCell.m
//  WhatsNextIOS
//
//  Created by Dragos on 19/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "AttachCell.h"

@implementation AttachCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _labelName.textColor = RGB(blue_back);
    self.backgroundColor = RGB(yellow0);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
