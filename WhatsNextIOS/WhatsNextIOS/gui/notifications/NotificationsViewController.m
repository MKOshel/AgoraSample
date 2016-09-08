//
//  NotificationsViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/19/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "NotificationsViewController.h"
#import "Notification.h"
#import "NotificationCell.h"
#import "AppDelegate.h"
#import "ScheduleDetailVC.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"NotificationCell" bundle:nil] forCellReuseIdentifier:@"NotificationCell"];
    _notifications = [Notification getNotifications];
    _tableView.separatorColor = RGB(yellow0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.title = @"Notificari";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddedNotification) name:NOTIFICATION_LOGIN object:nil];
    //[GU setNavigationBarColor:self.navigationController color:RGB(blue_back)];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    self.imageBack.image = [UIImage imageNamed:BACK];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

-(void) onAddedNotification{
    _notifications = [Notification getNotifications];
    [self.tableView reloadData];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL) slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Notification* n = [_notifications objectAtIndex:indexPath.row];
    if(n.agenda != nil)
    {
        //[APP.beaconManager openAgenda:n.agenda];
        ScheduleDetailVC* vc = (ScheduleDetailVC*)[GU getController:@"Events" identifier:@"ScheduleDetailVC"];
        vc.agenda = n.agenda;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(n.attachment != nil)
    {
        [APP.beaconManager openAttachment:n.attachment];
    }
    
    n.read = [NSNumber numberWithBool:YES];
    [DB save];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
    [self.tableView reloadData];
}




-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79.0;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_notifications count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    Notification* n = [_notifications objectAtIndex:indexPath.row];
    [cell setNotification:n];
    return cell;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        Notification* n = [_notifications objectAtIndex:indexPath.row];
        if(n)
        {
            [n MR_deleteEntity];
            [DB save];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
            _notifications = [Notification getNotifications];
            [APP.beaconManager registerBeacons];
            [_tableView reloadData];            
        }
    }
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
