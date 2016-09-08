//
//  RegisterFieldCell.h
//  WhatsNextIOS
//
//  Created by dragos on 5/22/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelKey;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonCell;

@property (weak, nonatomic) IBOutlet UILabel *labelWarning;
@property (weak, nonatomic) IBOutlet UITextField *labelValue;
@end
