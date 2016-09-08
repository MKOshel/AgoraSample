//
//  AccountViewController2.m
//  WhatsNextIOS
//
//  Created by dragos on 5/22/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "AccountViewController2.h"
#import "RegisterFieldCell.h"

#define IEMAIL 0
#define IUSERNAME 1
#define IPASSWORD 2
#define IPASSWORD2 3
#define IFIRSTNAME 4
#define ILASTNAME 5
#define ITITLE 6
#define IJOBTITLE 7
#define IPHONE 8

@interface AccountViewController2 ()

@end

@implementation AccountViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RegisterFieldCell" bundle:nil] forCellReuseIdentifier:@"RegisterFieldCell"];
    
    [_tableView configureWithDelegate:self andDataSource:self];
    self.navigationItem.title= @"Profil";
    _tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = RGB(yellow0);
    self.imageBack.image = [UIImage imageNamed:BACK];
    self.tableView.allowsSelection = NO;
    if(_data == nil)
    {
        _data = [[UserData alloc] init];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) resizableTableView:(MIResizableTableView *)resizableTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

-(CGFloat) resizableTableView:(MIResizableTableView *)resizableTableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

-(NSInteger) numberOfSectionsInResizableTableView:(MIResizableTableView *)resizableTableView{
    return 1;
}

-(NSInteger) resizableTableView:(MIResizableTableView *)resizableTableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 9;
    return 0;
}


-(UITableViewCell*) resizableTableView:(MIResizableTableView *)resizableTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegisterFieldCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"RegisterFieldCell"];
    cell.backgroundColor = [UIColor clearColor];
    if(indexPath.row == IEMAIL)
    {
        cell.labelKey.text = @"email";
        cell.textField.placeholder = @"email";
        cell.textField.text = _data.email;
        cell.textField.tag = IEMAIL;
    }
    if(indexPath.row == IUSERNAME)
    {
        cell.labelKey.text = @"username";
        cell.textField.placeholder = @"username";
        cell.textField.text = _data.username;
        cell.textField.tag = IUSERNAME;
    }
    if(indexPath.row == IPASSWORD)
    {
        cell.labelKey.text = @"parola";
        cell.textField.secureTextEntry = YES;
        cell.textField.placeholder = @"parola";
        cell.textField.text = _data.password;
        cell.textField.tag = IPASSWORD;
    }
    if(indexPath.row == IPASSWORD2)
    {
        cell.labelKey.text = @"confirma parola";
        cell.textField.secureTextEntry = YES;
        cell.textField.placeholder = @"confirma parola";
        cell.textField.text = _data.password;
        cell.textField.tag = IPASSWORD2;
    }
    if(indexPath.row == IFIRSTNAME)
    {
        cell.labelKey.text = @"prenume";
        cell.textField.placeholder = @"prenume";
        cell.textField.text = _data.firstName;
        cell.textField.tag = IFIRSTNAME;
    }
    if(indexPath.row == ILASTNAME)
    {
        cell.labelKey.text = @"nume";
        cell.textField.placeholder = @"nume";
        cell.textField.text = _data.lastName;
        cell.textField.tag = ILASTNAME;
    }
    if(indexPath.row == ITITLE)
    {
        cell.labelKey.text = @"titlu";
        cell.textField.placeholder = @"titlu";
        cell.textField.text = _data.title;
        cell.textField.tag = ITITLE;
        cell.textField.enabled = NO;
    }
    if(indexPath.row == IJOBTITLE)
    {
        cell.labelKey.text = @"functie";
        cell.textField.placeholder = @"functie";
        cell.textField.text = _data.jobTitle;
        cell.textField.tag = IJOBTITLE;
    }
    if(indexPath.row == IPHONE)
    {
        cell.labelKey.text = @"telefon";
        cell.textField.placeholder = @"telefon";
        cell.textField.text = _data.phone;
        cell.textField.tag = IPHONE;
    }

    
    cell.textField.delegate = self;
    
    [GU setPlaceholderColor:cell.textField color:RGB(grey50) text:cell.textField.placeholder];

    
    return cell;
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
   
}

-(BOOL) checkEmail:(UITextField*) textField{
    
    NSIndexPath* pEmail = [NSIndexPath indexPathForRow:IEMAIL inSection:0];
    NSIndexPath* pUsername = [NSIndexPath indexPathForRow:IUSERNAME inSection:0];
    RegisterFieldCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:IEMAIL inSection:0]];
    
    //_data.email = textField.text;
    NSString* error = [_data checkEmail];
    
    if(error)
    {
        
        cell.labelWarning.hidden = NO;
        cell.labelWarning.text = error;
        
        [_tableView reloadRowsAtIndexPaths:@[pEmail] withRowAnimation:UITableViewRowAnimationFade];
        [cell.textField becomeFirstResponder];
        return NO;
    }
    else{
        cell.labelWarning.hidden = YES;
        cell.labelWarning.text = @"";
        if(textField) {
            RegisterFieldCell* cell2 = [self.tableView cellForRowAtIndexPath:pUsername];
            [cell2.textField becomeFirstResponder];
            }
        [_tableView reloadRowsAtIndexPaths:@[pEmail] withRowAnimation:UITableViewRowAnimationFade];
        return YES;
    }
    

}

-(void) setFocus:(NSInteger) indexPath{
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];

    

    if(textField.tag == IEMAIL)
    {
        _data.email = textField.text;
        return [self checkEmail:textField];
        //[cell.textField becomeFirstResponder];
    }
    
    if(textField.tag == IUSERNAME)
    {
        _data.email = textField.text;
        return [self checkEmail:textField];
        //[cell.textField becomeFirstResponder];
    }
    return NO;
}

-(void) resizableTableView:(MIResizableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)keyboardWasShown:(NSNotification *)sender
{
    CGFloat height = [[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval duration = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curveOption = [[sender.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState|curveOption animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, height, 0);
        _tableView.contentInset = edgeInsets;
        _tableView.scrollIndicatorInsets = edgeInsets;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)sender
{
    NSTimeInterval duration = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curveOption = [[sender.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState|curveOption animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        _tableView.contentInset = edgeInsets;
        _tableView.scrollIndicatorInsets = edgeInsets;
    }completion:^(BOOL finished) {
        
    } ];
}

-(UIView*)resizableTableView:(MIResizableTableView *)resizableTableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return [self getHeader:_tableView title:@"Profil"];
    if(section == 1)
        return  [self getHeader:_tableView title:@"Atasamente"];
    return nil;
}


-(UIView*)getHeader:(UITableView*)tableView title:(NSString*) title
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    headerView.backgroundColor = RGB(yellow0);
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 5, tableView.frame.size.width - 5, 30);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = RGB(grey800);
    headerLabel.font = [UIFont boldSystemFontOfSize:17.0];
    headerLabel.text = title;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:headerLabel];
    return headerView;
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
