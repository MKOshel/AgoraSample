//
//  LoginViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginFormTextField.h"
#import "RequestManager.h"
#import "SlideNavigationController.h"
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate,LoginComDelegate>
@property (weak, nonatomic) IBOutlet LoginFormTextField *textEditUsername;
@property (weak, nonatomic) IBOutlet LoginFormTextField *textEditPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@end
