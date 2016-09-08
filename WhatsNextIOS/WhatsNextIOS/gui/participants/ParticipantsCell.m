//
//  ParticipantsCell.m
//  WhatsNextIOS
//
//  Created by Oshel on 5/19/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "ParticipantsCell.h"

@implementation ParticipantsCell

- (void)awakeFromNib {
    // Initialization code
    [self customize];
}


-(void)customize
{
    self.backgroundColor = [UIColor clearColor];
    self.labelName.textColor = RGB(yellow0);
    self.labelJob.textColor = RGB(yellow0);
    self.labelMail.textColor = RGB(yellow0);

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
