//
//  LoginViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.imageBack.image = [UIImage imageNamed:BACK];
    _textEditPassword.delegate = _textEditUsername.delegate = self;
    [GU makeTransparentNavigationBar:self.navigationController];
    //self.navigationItem.title=NSLocalizedString(@"title_register_screen", nil);
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [_textEditUsername becomeFirstResponder];
    
}

-(void) onLoginResponse:(BOOL)success result:(NSDictionary *)result error:(NSError *)error{
    [self stopLoading];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
    if(success)
    {
        UIViewController* vc = [GU getController:@"Events" identifier:@"EventsViewController"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:YES
                                                                         andCompletion:nil];
    }
    else{
        [RU showError:self errorString:@"Invalid login"];
    }
}

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}

- (IBAction)onLogin:(id)sender {
    [self onLoginPressed];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField == _textEditUsername)
    {
        [_textEditPassword becomeFirstResponder];
        return YES;
    }
    if(textField == _textEditPassword)
    {
        [_textEditPassword resignFirstResponder];
        [self onLoginPressed];
        
    }
    return YES;
}

-(void) onLoginPressed{
    [_textEditPassword resignFirstResponder];
    [_textEditUsername resignFirstResponder];
    NSString* username = _textEditUsername.text;
    NSString* password = _textEditPassword.text;
    RequestManager* rm = [[RequestManager alloc] init];
    rm.delegateLogin = self;
    [self startLoading];
    [rm login:username password:password];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
