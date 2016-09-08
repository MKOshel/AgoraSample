//
//  AccountViewController.h
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BPForms/BPFormViewController.h>
#import "ProfileCom.h"
#import "User.h"


@interface AccountViewController : BPFormViewController<ProfileComDelegate>

@property(nonatomic, retain) User* user;

@end
