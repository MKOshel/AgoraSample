//
//  DrawerViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "DrawerViewController.h"
#import "DrawerCell.h"
#import "RegisterViewController.h"
#import "InitialViewController.h"
#import "ScheduleViewController.h"
#import "Notification.h"

@implementation DrawerViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _viewHeader.backgroundColor = [UIColor clearColor];
    if([SM getCurrentEvent] == nil)
        _labelCurrentEvent.text = @"";
    else
        _labelCurrentEvent.text = [SM getCurrentEvent].name;
    _labelCurrentEvent.textColor = RGB(yellow0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"DrawerCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"DrawerCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginChange) name:NOTIFICATION_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginChange) name:NOTIFICATION_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEventChanged) name:NOTIFICATION_EVENT_CHANGED object:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void) onLoginChange{
    [self.tableView reloadData];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void) onEventChanged{
    
    if([SM getCurrentEvent] != nil)
        _labelCurrentEvent.text = [SM getCurrentEvent].name;
    else
        _labelCurrentEvent.text = @"";
    [_tableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52.0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Event* e = [SM getCurrentEvent];
    return 7;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void) showAgenda:(Event*) e{
    if(e == nil)
        return;
    ScheduleViewController* vc = (ScheduleViewController*)[GU getController:@"Events" identifier:@"ScheduleViewController"];
    vc.event = e;
    [GU showViewController:vc];

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Event* e = [SM getCurrentEvent];
    
    if(indexPath.row == 0)
    {
        [self showEvents];
    }
    
    if(indexPath.row == 1 && e)
    {
        [self showAgenda:e];
        return;
    }
    
    if (indexPath.row == 2 && e) {
        
        UIViewController* vc = [GU getController:@"Participants" identifier:@"ParticipantsVC"];
        [GU showViewController:vc];
    }
    
    if (indexPath.row == 3 && e) {
        UIViewController* vc = [GU getController:@"Participants" identifier:@"OrganizersVC"];
        [GU showViewController:vc];
    }
    
    if (indexPath.row == 4) {
        UIViewController* vc = [GU getController:@"Main" identifier:@"NotificationsViewController"];
        [GU showViewController:vc];
    }
    
    if(indexPath.row == 5 && ![RM isAuthenticated])
    {
        UIViewController* ctrl = [GU getController:@"Main" identifier:@"LoginViewController"];
        [GU showViewController:ctrl];
    }
    
    if(indexPath.row == 6 && [RM isAuthenticated])
    {
        RequestManager* rm = [[RequestManager alloc] init];
        rm.delegateLogin = self;
        [rm logout];
        [self startLoading];
    }
    if(indexPath.row == 6 && ![RM isAuthenticated])
    {
        RegisterViewController* vc = [[RegisterViewController alloc] init];
        [GU showViewController:vc];
    }
}

-(void) showEvents{
    UIViewController* vc = [GU getController:@"Events" identifier:@"EventsViewController"];
    [GU showViewController:vc];
}

-(void) onLogoutResponse:(BOOL)success result:(NSDictionary *)result error:(NSError *)error{
    [self stopLoading];
    if(success)
    {
        [SM setToken:nil];
        [RM setAuthenticated:NO];
    }
    [self.tableView reloadData];
    UIViewController* vc = [GU getController:@"Main" identifier:@"InitialViewController"];
    [GU showViewController:vc];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DrawerCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DrawerCell"];
    Event* e = [SM getCurrentEvent];
    if(indexPath.row == 0)
    {
        cell.labelDrawer.text = @"evenimente";
        cell.imageDrawer.image = [UIImage imageNamed:@"drawer_events.png"];
    }

    if(indexPath.row == 1)
    {
        cell.labelDrawer.text = @"program";
        cell.imageDrawer.image = [UIImage imageNamed:@"drawer_program.png"];
        if(!e)
        {
            cell.labelDrawer.enabled = NO;
        }
        else
        {
            cell.labelDrawer.enabled = YES;
        }
    }

    if(indexPath.row == 2)
    {
        cell.labelDrawer.text = @"participanti";
        cell.imageDrawer.image = [UIImage imageNamed:@"drawer_participants.png"];
        if(!e)
        {
            cell.labelDrawer.enabled = NO;
        }
        else
        {
            cell.labelDrawer.enabled = YES;
        }
    }

    if(indexPath.row == 3)
    {
        cell.labelDrawer.text = @"organizatori";
        cell.imageDrawer.image = [UIImage imageNamed:@"drawer_organizers.png"];
        if(!e)
        {
            cell.labelDrawer.enabled = NO;
        }
        else
        {
            cell.labelDrawer.enabled = YES;
        }
    }

    if(indexPath.row == 4)
    {
        cell.labelDrawer.text = @"notificari";
        cell.imageDrawer.image = [UIImage imageNamed:@"ic_notifications.png"];
        [cell setNumberOfNotifications:[Notification getUnreadCount]];
        
    }

    
    if(indexPath.row == 5)
    {
        if([RM isAuthenticated])
            cell.labelDrawer.text = @"contul meu";
        else
            cell.labelDrawer.text = @"login";

        cell.imageDrawer.image = [UIImage imageNamed:@"drawer_my_account.png"];
    }
    
    
    if(indexPath.row == 6)
    {
        if([RM isAuthenticated])
        {
            cell.labelDrawer.text = @"Logout";
            cell.imageDrawer.image = [UIImage imageNamed:@"ic_logout_drawer.png"];
        }
        else
        {
            cell.labelDrawer.text = @"Register";
            cell.imageDrawer.image = [UIImage imageNamed:@"ic_logout_drawer.png"];
        }
    }

    
    return cell;
    
}


@end
