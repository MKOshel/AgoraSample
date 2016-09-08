//
//  RegisterFieldCell.m
//  WhatsNextIOS
//
//  Created by dragos on 5/22/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RegisterFieldCell.h"

@implementation RegisterFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.labelKey.textColor = RGB(yellow0);
    self.textField.textColor = RGB(yellow0);
    self.buttonCell.hidden = YES;
    //[GU setPlaceholderColor:self.textField color:RGB(grey50) text:self.textField.placeholder];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
