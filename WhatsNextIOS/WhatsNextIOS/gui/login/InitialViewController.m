//
//  InitialViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "InitialViewController.h"
#import "EventsViewController.h"
#import "RegisterViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageBack.image = [UIImage imageNamed:BACK];
    self.navigationController.navigationBar.tintColor = RGB(yellow0);
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(yellow0)}];
    

    [GU makeTransparentNavigationBar:self.navigationController];
    
    [RM checkAuthenticated];
    
    if([RM isAuthenticated])
    {
        UIViewController* vc = [GU getController:@"Events" identifier:@"EventsViewController"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:YES
                                                                         andCompletion:nil];

    }
    // Do any additional setup after loading the view.
}


-(BOOL) slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogin:(id)sender {
    
    UIViewController* vc = [GU getController:@"Main" identifier:@"LoginViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)onRegister:(id)sender {
    UIViewController* ctrl = [GU getController:@"RegisterAccount" identifier:@"AccountViewController2"];
    
    [self.navigationController pushViewController:ctrl animated:NO];
}
- (IBAction)onPublicEvents:(id)sender {
    UIViewController* vc = [GU getController:@"Events" identifier:@"EventsViewController"];
    [GU showViewController:vc];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
