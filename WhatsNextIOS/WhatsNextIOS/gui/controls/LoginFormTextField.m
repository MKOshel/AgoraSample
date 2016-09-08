//
//  LoginFormTextField.m
//  RoadVikings
//
//  Created by dragos on 3/31/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "LoginFormTextField.h"

@implementation LoginFormTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) drawBottomBorder{
    //draw bottom border
  _bottomBorder = [CALayer layer];
_bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
    _bottomBorder.backgroundColor = RGB(yellow0).CGColor;
    [self.layer addSublayer:_bottomBorder];
    
}

-(void) initTextField{
    [self setTextColor:RGB(grey50_30)];
    [self setFont:[UIFont fontWithName:self.font.fontName size:18.0]];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: RGB(grey50_70)}];
    [self drawBottomBorder];
}

-(void) layoutSubviews{
    [super layoutSubviews];
    _bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initTextField];
        
    }
    return self;
}

@end
