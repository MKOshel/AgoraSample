//
//  ParticipantsVC.m
//  WhatsNextIOS
//
//  Created by Dragos on 18/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "ParticipantsVC.h"
#import "CategoryView.h"
#import "User.h"
#import "ParticipantsCell.h"

@interface ParticipantsVC ()
{
    NSMutableArray* participants;
    NSMutableArray* filteredParticipants;
    UITableView* tvResults;
}
@end

@implementation ParticipantsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self getEvents];
    self.navigationItem.title = @"Participanti";
    participants = (NSMutableArray*)[Event getParticipantsForEvent:[SM getCurrentEvent].unique.longValue];
    tvResults = self.searchDisplayController.searchResultsTableView;
    
    [self customizeView];

    // Do any additional setup after loading the view.
}

-(BOOL) slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}



-(void)customizeView
{
    self.searchDisplayController.searchBar.tintColor    = RGB(yellow0);
    self.searchDisplayController.searchBar.barTintColor = [UIColor blackColor];
    self.searchDisplayController.searchBar.backgroundImage = [UIImage new];
    [self.searchDisplayController.searchBar setSearchBarStyle:UISearchBarStyleMinimal];

    self.imageBack.image = [UIImage imageNamed:BACK];
    _tableView.separatorColor = RGB(yellow0);
    _tableView.backgroundColor = [UIColor clearColor];
    tvResults.backgroundColor = [UIColor blackColor];
    tvResults.separatorColor = RGB(yellow0);

    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [tvResults setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ParticipantsCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"ParticipantsCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tvResults]) {
        return filteredParticipants.count;
    }
    return participants.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParticipantsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        User* user = filteredParticipants[indexPath.row];
          [self configureCell:cell user:user];
    }
    
    else {
        User* user = participants[indexPath.row];
        [self configureCell:cell user:user];

    }
    return cell;
}

-(ParticipantsCell*)configureCell:(ParticipantsCell*)cell user:(User*)user
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
    [filteredParticipants removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name  contains[c] %@", searchText];
    
    filteredParticipants = [NSMutableArray arrayWithArray:[participants filteredArrayUsingPredicate:resultPredicate]];
    
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
