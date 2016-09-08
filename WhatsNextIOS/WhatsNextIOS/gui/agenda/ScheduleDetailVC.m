//
//  ScheduleDetailVC.m
//  WhatsNextIOS
//
//  Created by Dragos on 18/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "ScheduleDetailVC.h"
#import "BeaconManager.h"
#import "AppDelegate.h"
#import "Attachment.h"
#import "DUtils.h"
#import "DetailCell.h"
#import "AttachCell.h"
#import "Attachment.h"

@interface ScheduleDetailVC ()
{
}
@end

@implementation ScheduleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    [self.tableView configureWithDelegate:self andDataSource:self];
    _attachments = [_agenda.attachments allObjects];
    
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [_tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"AttachCell" bundle:nil] forCellReuseIdentifier:@"attachCell"];
    
    self.title = [SM getCurrentEvent].name;
    _labelAgendaName.text = _agenda.name;
    _labelAgendaName.textColor = RGB(yellow0);
}



#pragma TableView data & delegate
-(NSInteger) resizableTableView:(MIResizableTableView *)resizableTableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    if(section == 1)
        return [_attachments count];
    return 0;
}

-(NSInteger) numberOfSectionsInResizableTableView:(MIResizableTableView *)resizableTableView{
    return 2;
}


-(UITableViewCell*) resizableTableView:(MIResizableTableView *)resizableTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 0){
        DetailCell* c = [_tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        
        NSString* time = [NSString stringWithFormat:@"%@-%@",[RdUtils getTimeString:_agenda.startTime],[RdUtils getTimeString:_agenda.endTime]];
        c.labelTime.text = time;
        
        NSString* speakerNames = [_agenda getSpeakerNames];
        if(speakerNames != nil && ![speakerNames isEqualToString:@""])
            c.labelSpeakers.text = speakerNames;
        else
            c.labelSpeakers.text = @"";
        c.labelDescr.text = _agenda.descr;
        
       
        if (_agenda.availablePlaces == nil || _agenda.mandatory.boolValue == YES) {
            c.labelSeatsNumber.hidden = YES;

        }
        else {
            c.labelSeatsNumber.hidden = NO;
            c.labelSeatsNumber.text = [NSString stringWithFormat:@"%@ locuri",_agenda.availablePlaces.stringValue];
        }
        
        return c;
    }
    
    if(indexPath.section == 1)
    {
        AttachCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"attachCell"];
        Attachment* at = [_attachments objectAtIndex:indexPath.row];
        cell.labelName.text = at.blobName;
        return cell;
    }
    return nil;
}


-(void)resizableTableView:(MIResizableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.section == 1)
    {
        Attachment * att = (Attachment*)[_attachments objectAtIndex:indexPath.row];
        [APP.beaconManager openAttachment:att];
    }
    
}



-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    [view setBackgroundColor:RGB(yellow0)];
}


-(UIView*)resizableTableView:(MIResizableTableView *)resizableTableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return [self getHeader:_tableView title:@"Detalii"];
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

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

-(CGFloat) resizableTableView:(MIResizableTableView *)resizableTableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

-(CGFloat)resizableTableView:(MIResizableTableView *)resizableTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
        return 60.0;
    return UITableViewAutomaticDimension;
}



#pragma mark document
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
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
