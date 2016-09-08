//
//  CVDayCell.m
//  WhatsNextIOS
//
//  Created by Dragos on 13/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "CVDayCell.h"
#import "GuiUtils.h"

@implementation CVDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.labelDate.textColor = RGB(blue_back);
    self.labelDate.backgroundColor = RGB(yellow0);
    // Initialization code
}

@end
