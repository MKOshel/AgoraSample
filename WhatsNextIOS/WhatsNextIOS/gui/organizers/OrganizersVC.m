//
//  OrganizersVC.m
//  WhatsNextIOS
//
//  Created by Dragos on 18/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "OrganizersVC.h"
#import "CategoryView.h"
#import "ParticipantsCell.h"

@interface OrganizersVC ()
{
    NSMutableArray* organizers;
    NSMutableArray* filteredOrganizers;
    UITableView* tvResults;
}
@end

@implementation OrganizersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
    organizers = (NSMutableArray*)[Event getOrganizersForEvent:[SM getCurrentEvent].unique.longValue];
    tvResults = self.searchDisplayController.searchResultsTableView;
    
    // Do any additional setup after loading the view.
}


-(void)customizeView
{
    self.searchDisplayController.searchBar.tintColor    = RGB(yellow0);
    self.searchDisplayController.searchBar.barTintColor = [UIColor blackColor];
    self.searchDisplayController.searchBar.backgroundImage = [UIImage new];
    [self.searchDisplayController.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    
    self.imageback.image = [UIImage imageNamed:BACK];
    _tableView.separatorColor = RGB(yellow0);
    _tableView.backgroundColor = [UIColor clearColor];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor blackColor];
    self.searchDisplayController.searchResultsTableView.separatorColor = RGB(yellow0);
    
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [tvResults setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ParticipantsCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"ParticipantsCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.navigationItem.title = @"Organizatori";
  
}


-(BOOL) slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

#pragma mark - TableViewDataSource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tvResults]) {
        return filteredOrganizers.count;
    }
    return organizers.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParticipantsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        User* user = filteredOrganizers[indexPath.row];
        [self configureCell:cell withUser:user];
        
    }
    else {
        User* user = organizers[indexPath.row];
        [self configureCell:cell withUser:user];
    }
    return cell;
}

-(ParticipantsCell*)configureCell:(ParticipantsCell*)cell withUser:(User*)user
{
    cell.labelName.text = user.name;
    if (user.jobTitle == nil) {
        cell.labelJob.text = @"fara";
    }
    else cell.labelJob.text = user.jobTitle;
    if (user.email == nil) {
        cell.labelMail.text = @"fara";
    }
    else cell.labelMail.text = user.email;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tvResults]) {
        return 84;
    }
    return 84;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [filteredOrganizers removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    
    filteredOrganizers = [NSMutableArray arrayWithArray:[organizers filteredArrayUsingPredicate:resultPredicate]];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
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
