//
//  EventsViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/9/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "EventsViewController.h"
#import "Event.h"
#import "ScheduleViewController.h"
#import "EventsCell.h"
#import "DUtils.h"

#define screenTitle @"Evenimente"
@interface EventsViewController ()
{
    UITableView* tvResults;
}
@end


@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self customizeView];
    [self getEvents];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLogout) name:NOTIFICATION_LOGOUT object:nil];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[GU image:[UIImage imageNamed:@"ic_sync.png"] scaledToSize:CGSizeMake(30.0,30.0)] style:UIBarButtonItemStylePlain target:self action:@selector(onRefresh)];
    self.navigationItem.rightBarButtonItem = item;
    
    tvResults = self.searchDisplayController.searchResultsTableView;
    // Do any additional setup after loading the view.
}

-(void) onRefresh{
    [self getEvents];
}

-(void) onLogout{
    [self getEvents];
}

-(void)customizeView
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [_tableView registerNib:[UINib nibWithNibName:@"EventsCell" bundle:nil] forCellReuseIdentifier:@"eventsCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"EventsCell" bundle:nil] forCellReuseIdentifier:@"eventsCell"];
    //_tableView.separatorColor  = RGB(yellow0);
    //self.view.backgroundColor  = RGB(blue_back);
    //self.view.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"candela.png"]];
    _imageBack.image = [UIImage imageNamed:BACK];
    _tableView.backgroundColor = [UIColor clearColor];
    self.title = screenTitle;
    
    self.searchDisplayController.searchBar.tintColor    = RGB(yellow0);
    self.searchDisplayController.searchBar.barTintColor = [UIColor blackColor];
    self.searchDisplayController.searchBar.backgroundImage = [UIImage new];
    [self.searchDisplayController.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    UITextField* tfSearch = [self.searchDisplayController.searchBar valueForKey:@"searchField"];
    tfSearch.textColor = [UIColor lightGrayColor];
    
    self.imageBack.image = [UIImage imageNamed:BACK];
    _tableView.separatorColor = RGB(yellow0);
    _tableView.backgroundColor = [UIColor clearColor];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor blackColor];
    self.searchDisplayController.searchResultsTableView.separatorColor = [UIColor clearColor];
    
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.searchDisplayController.searchResultsTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) getEvents{
    if([RU hasInternet])
    {
        [self startLoading:@"Se incarca evenimentele..."];
        EventsCom* req = [[EventsCom alloc] init];
        req.delegate = self;
        [req getEvents];
    }
    else{
        if([RM isAuthenticated])
            _events = (NSMutableArray*)[Event getEvents];
        else
            _events = (NSMutableArray*)[Event getPublicEvents];
        [_tableView reloadData];
    }
}




-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:tvResults]) {
        return _filteredEvents.count;
    }
    return _events.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void) onEventsReceived:(BOOL)success response:(NSMutableArray *)response error:(NSError *)err{
    [self stopLoading];
    if(success)
    {
        if([RM isAuthenticated])
            _events = (NSMutableArray*)[Event getEvents];
        else
            _events = (NSMutableArray*)[Event getPublicEvents];
        [_tableView reloadData];
    }
    else{
        
        [RU showError:self errorString:@"Eroare la preluarea evenimentelor"];
        if(![RM isAuthenticated])
            _events = (NSMutableArray*)[Event getPublicEvents];
        else
            _events = (NSMutableArray*)[Event getEvents];
        [_tableView reloadData];
    }
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"eventsCell"];

    if ([tableView isEqual:tvResults]) {
        Event* ev = [_filteredEvents objectAtIndex:indexPath.section];
        [self configureCell:cell withEvent:ev];
    }
    
    else {
        Event* ev = [_events objectAtIndex:indexPath.section];
        [self configureCell:cell withEvent:ev];
    }
    
//      Event* ev = [_events objectAtIndex:indexPath.section];
//   
//      cell.labelName.text = ev.name;
//      NSString* startDate = [DUtils getDayStringPrettyPrinted:ev.startDate];
//      NSString* endDate = [DUtils getDayStringPrettyPrinted:ev.endDate];
//    
//      NSString* addressTime = [NSString stringWithFormat:@"%@/%@ - %@",ev.address,startDate,endDate];
//      cell.labelAddress.text = addressTime;
    
      return cell;
}

-(EventsCell*)configureCell:(EventsCell*)cell withEvent:(Event*)ev
{
    cell.labelName.text = ev.name;
    NSString* startDate = [DUtils getDayStringPrettyPrinted:ev.startDate];
    NSString* endDate = [DUtils getDayStringPrettyPrinted:ev.endDate];
    
    NSString* addressTime = [NSString stringWithFormat:@"%@/%@ - %@",ev.address,startDate,endDate];
    cell.labelAddress.text = addressTime;
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Event* e;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        e = _filteredEvents[indexPath.section];
    }
    
   else e = [_events objectAtIndex:indexPath.section];
    
    ScheduleViewController* vc = (ScheduleViewController*)[GU getController:@"Events" identifier:@"ScheduleViewController"];
    vc.event = e;
    [SM setSelectedEvent:e];
    [self.navigationController pushViewController:vc animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tvResults]) {
        return 160;
    }
    return 160;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [_filteredEvents removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name  contains[c] %@", searchText];
    
    _filteredEvents = [NSMutableArray arrayWithArray:[_events filteredArrayUsingPredicate:resultPredicate]];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
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
