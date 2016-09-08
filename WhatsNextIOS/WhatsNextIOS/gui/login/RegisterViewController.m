//
//  RegisterViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/18/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "RegisterViewController.h"
#import <BPForms/BPFormFloatInputTextFieldCell.h>
#import <BPForms/BPFormFloatInputTextViewCell.h>
#import <BPForms/BPFormButtonCell.h>
#import <BPForms/BPFormInfoCell.h>
#import <BPForms/BPAppearance.h>
#import "UserData.h"
#import "ProfileCom.h"
#import "SwiftSpinner-Swift.h"


@interface RegisterViewController ()

@end



@implementation RegisterViewController

-(void) prepareError:(BPFormInputCell*) cell{
    cell.infoCell.contentView.backgroundColor = [UIColor clearColor];
    cell.infoCell.backgroundColor = [UIColor clearColor];
    cell.infoCell.label.textColor = RGB(yellow0);
}

-(void) prepareTextBox:(BPFormInputTextFieldCell*) cell{
    cell.textField.backgroundColor = [UIColor clearColor];;
    cell.textField.layer.borderColor = RGB(yellow0).CGColor;
    cell.textField.textColor = RGB(yellow0);
    cell.backgroundColor = [UIColor clearColor];
    [GU setPlaceholderColor:cell.textField color:RGB(grey50) text:cell.textField.placeholder];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    //self.navigationController.navigationBar.translucent = NO;
    //[BPAppearance sharedInstance].inputCellTextFieldFloatingLabelFont = [UIFont systemFontOfSize:12];

    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    _imageBack.image = [UIImage imageNamed:BACK];
    
    BOOL isIOS7orLater = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
    
    Class inputTextFieldClass = isIOS7orLater ? [BPFormFloatInputTextFieldCell class] : [BPFormInputTextFieldCell class];

    
    self.title = @"Inregistrare";
    
    BPFormInputTextFieldCell *emailCell = [[inputTextFieldClass alloc] init];
    emailCell.textField.placeholder = @"Email";
    emailCell.textField.delegate = self;
    [GU setPlaceholderColor:emailCell.textField color:RGB(yellow0) text:@"Email"];
    emailCell.customCellHeight = 40.0f;
    [self prepareTextBox:emailCell];
    emailCell.mandatory = YES;
    emailCell.shouldChangeTextBlock =  ^BOOL(BPFormInputCell *inCell, NSString *inText) {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailRegEx
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        
        if (inText.length && (1 == [regex numberOfMatchesInString:inText options:0 range:NSMakeRange(0, [inText length])]) ) {
            inCell.validationState = BPFormValidationStateValid;
            inCell.shouldShowInfoCell = NO;
        } else if (!inCell.mandatory && !inText.length) {
            inCell.validationState = BPFormValidationStateNone;
            inCell.shouldShowInfoCell = NO;
        } else {
            inCell.validationState = BPFormValidationStateInvalid;
            inCell.infoCell.label.text = @"The email should look like name@provider.domain";
            inCell.shouldShowInfoCell = YES;
            [self prepareError:inCell];
        }
        return YES;
    };
    
    
    BPFormInputTextFieldCell *usernameCell = [[inputTextFieldClass alloc] init];
    usernameCell.textField.placeholder = @"Username";
    usernameCell.textField.delegate = self;
    usernameCell.textField.secureTextEntry = NO;
    usernameCell.spaceToNextCell = 2.0f;
    usernameCell.contentView.backgroundColor = [UIColor clearColor];
    usernameCell.customCellHeight = 40.0f;
    usernameCell.mandatory = YES;
    [self prepareTextBox:usernameCell];
    usernameCell.shouldChangeTextBlock = ^BOOL(BPFormInputCell *inCell, NSString *inText) {
        if (inText.length >= 5) {
            inCell.validationState = BPFormValidationStateValid;
            inCell.shouldShowInfoCell = NO;
            inCell.backgroundColor = [UIColor clearColor];
            inCell.textLabel.textColor = RGB(yellow0);
        } else {
            inCell.validationState = BPFormValidationStateInvalid;
            inCell.infoCell.label.text = @"Username-ul trebuie sa aiba minim 5 caractere";
            inCell.shouldShowInfoCell = YES;
            [self prepareError:inCell];
        }
        return YES;
    };
    
    //BPValidateBlockWithPatternAndMessage(, @"The email should look like name@provider.domain");
    
    BPFormInputTextFieldCell *passwordCell = [[inputTextFieldClass alloc] init];
    passwordCell.textField.placeholder = @"Parola";
    passwordCell.textField.delegate = self;
    passwordCell.textField.secureTextEntry = YES;
    passwordCell.spaceToNextCell = 2.0f;
    passwordCell.contentView.backgroundColor = [UIColor clearColor];
    passwordCell.customCellHeight = 40.0f;
    passwordCell.mandatory = YES;
    [self prepareTextBox:passwordCell];
    passwordCell.shouldChangeTextBlock = ^BOOL(BPFormInputCell *inCell, NSString *inText) {
        if (inText.length >= 5) {
            inCell.validationState = BPFormValidationStateValid;
            inCell.shouldShowInfoCell = NO;
            inCell.backgroundColor = [UIColor clearColor];
            inCell.textLabel.textColor = RGB(yellow0);
        } else {
            inCell.validationState = BPFormValidationStateInvalid;
            inCell.infoCell.label.text = @"Parola trebuie sa aiba minim 5 caractere";
            inCell.shouldShowInfoCell = YES;
            [self prepareError:inCell];
        }
        return YES;
    };
    
    BPFormInputTextFieldCell *password2Cell = [[inputTextFieldClass alloc] init];
    password2Cell.textField.placeholder = @"Verifica parola";
    password2Cell.textField.delegate = self;
    password2Cell.contentView.backgroundColor= [UIColor clearColor];
    password2Cell.textField.secureTextEntry = YES;
    password2Cell.customCellHeight = 40.0f;
    password2Cell.mandatory = YES;
    [self prepareTextBox:password2Cell];
    password2Cell.shouldChangeTextBlock = ^BOOL(BPFormInputCell *inCell, NSString *inText) {
        if (inText.length && [inText isEqualToString:passwordCell.textField.text]) {
            inCell.validationState = BPFormValidationStateValid;
            inCell.shouldShowInfoCell = NO;
        } else {
            inCell.validationState = BPFormValidationStateInvalid;
            inCell.infoCell.label.text = @"Parolele nu coincid";
            inCell.shouldShowInfoCell = YES;
            inCell.contentView.backgroundColor = [UIColor clearColor];
            inCell.infoCell.contentView.backgroundColor = [UIColor clearColor];
            inCell.infoCell.backgroundColor = [UIColor clearColor];
            inCell.infoCell.label.textColor = RGB(yellow0);
        }
        return YES;
    };
    
    BPFormInputTextFieldCell *nameCell = [[inputTextFieldClass alloc] init];
    nameCell.textField.placeholder = @"Nume";
    nameCell.textField.delegate = self;
    nameCell.customCellHeight = 40.0f;
    [self prepareTextBox:nameCell];

    BPFormInputTextFieldCell *prenume = [[inputTextFieldClass alloc] init];
    prenume.textField.placeholder = @"Prenume";
    prenume.textField.delegate = self;
    prenume.customCellHeight = 40.0f;
    [self prepareTextBox:prenume];

    
    BPFormInputTextFieldCell *phoneCell = [[inputTextFieldClass alloc] init];
    phoneCell.textField.placeholder = @"telefon";
    phoneCell.textField.delegate = self;
    phoneCell.textField.keyboardType = UIKeyboardTypePhonePad;
    phoneCell.customCellHeight = 40.0f;
    phoneCell.spaceToNextCell = 20.0f;
    [self prepareTextBox:phoneCell];
    
    
    
    BPFormButtonCell *signUpCell = [[BPFormButtonCell alloc] init];
    [signUpCell.button setTitle:@"Inregistreaza-te" forState:UIControlStateNormal];
    signUpCell.contentView.backgroundColor = [UIColor clearColor];
    signUpCell.button.backgroundColor = RGB(yellow0);
    signUpCell.backgroundColor = [UIColor clearColor];
    signUpCell.button.layer.cornerRadius = 0.0;
    signUpCell.button.layer.masksToBounds = YES;
    [signUpCell.button setTitleColor:RGB(blue_back) forState:UIControlStateNormal];
    //signUpCell.customContentWidth = 220;
    signUpCell.buttonActionBlock = ^(void){
        NSLog(@"Button pressed");
        
        [emailCell.textField resignFirstResponder];
        [passwordCell.textField resignFirstResponder];
        [password2Cell.textField resignFirstResponder];
        [nameCell.textField resignFirstResponder];
        [prenume.textField resignFirstResponder];
        [phoneCell.textField resignFirstResponder];
        UserData* ud = [[UserData alloc] init];
        ud.firstName = prenume.textField.text;
        ud.lastName = nameCell.textField.text;
        ud.password = passwordCell.textField.text;
        ud.email = emailCell.textField.text;
        ud.phone = phoneCell.textField.text;
        ud.username = usernameCell.textField.text;
        
    };
    
    self.formCells = @[@[emailCell, usernameCell, passwordCell, password2Cell,prenume, nameCell, phoneCell,signUpCell]];
    
    //[self setHeaderTitle:@"Please enter your credentials" forSection:0];
    
    //[self setFooterTitle:@"When you're done, press <<Sign Up>>" forSection:0];
    
    self.customSectionHeaderHeight = 30;
    
    // Do any additional setup after loading the view.
    
    [BPAppearance sharedInstance].infoCellLabelBackgroundColor = [UIColor clearColor];
    [BPAppearance sharedInstance].inputCellBackgroundColor = [UIColor clearColor];
    [BPAppearance sharedInstance].tableViewBackGroundColor = [UIColor clearColor];
}

-(void) onRegister:(UserData*) data{
    ProfileCom* req = [[ProfileCom alloc] init];
    req.delegate = self;
    [req registerProfile:data];
    [SwiftSpinner show:@"Registering" animated:YES];
}

-(void) onAccountUpdate:(BOOL)success error:(NSError *)error{
    [SwiftSpinner hide:^{
        
    }];
    if(success)
    {
        [RU showNotification:self message:@"Cont creat cu succes ! Verificati-va email-ul pentru activarea contului"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [RU showError:self errorString:@"O eroare a avut loc la crearea contului.Va rugam incercati mai tarziu."];
    }
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
