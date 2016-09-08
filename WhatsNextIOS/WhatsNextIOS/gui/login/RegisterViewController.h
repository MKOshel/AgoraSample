//
//  RegisterViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BPForms/BPFormViewController.h>
#import "ProfileCom.h"

@interface RegisterViewController : BPFormViewController<ProfileComDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@end
