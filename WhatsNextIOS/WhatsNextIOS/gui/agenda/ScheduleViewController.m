//
//  ScheduleViewController.m
//  WhatsNextIOS
//
//  Created by dragos on 5/10/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "ScheduleViewController.h"
#import "Event.h"
#import "DayAgendas.h"
#import "CVDayCell.h"
#import "Agenda.h"
#import "AgendasCom.h"

#import "ScheduleDetailVC.h"
#import "DUtils.h"

#define screenTitle @"Agenda"
@interface ScheduleViewController ()
{
    NSMutableArray* agendas;
    NSMutableArray* expandedIndexPaths;
    int selectedIndex;
    NSIndexPath* idxPath;
    Agenda* agenda;
}
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self customizeView];
    [self setupCollectionView];
    [self loadEvent];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPressBtnMore:) name:@"morePressed" object:nil];
    
    expandedIndexPaths = [NSMutableArray new];
}




-(void)customizeView
{
    self.title = _event.name;
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [_tableView registerNib:[UINib nibWithNibName:@"TVAgendaCell" bundle:nil] forCellReuseIdentifier:@"agendaCell"];
    _tableView.separatorColor = RGB(yellow0);
    self.view.backgroundColor = RGB(blue_back);
    self.imageBack.image = [UIImage imageNamed:BACK];
    _segmentedSchedule.tintColor = RGB(yellow0);
    //refresh
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 64;

    UIBarButtonItem* it = [[UIBarButtonItem alloc] initWithImage:[GU image:[UIImage imageNamed:@"ic_sync"] scaledToSize:CGSizeMake(30.0, 30.0)] style:UIBarButtonItemStylePlain target:self action:@selector(onRefreshPressed)];
    self.navigationItem.rightBarButtonItem = it;
}


-(void) onJoinAgenda:(long)agendaId row:(NSInteger)row{
    _row = row;
    [self startLoading:@"Se confirma participarea ..."];
    AgendasCom* req = [[AgendasCom alloc] init];
    req.delegate = self;
    [req joinAgenda:agendaId];
}

-(void) onJoinedAgenda:(BOOL)success agendaId:(long)agendaId error:(NSError *)e{
    [self stopLoading];
    if(success)
    {
        TVAgendaCell* cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_row inSection:0]];
        Agenda* a = [Agenda getAgenda:cell.agendaId];
        if(a.availablePlaces != nil)
            a.availablePlaces = [NSNumber numberWithLong:[a.availablePlaces longValue] -1];
        a.joined = [NSNumber numberWithBool:YES];
        [cell setAgenda:a row:_row];

    }
    else{
        [RU showRedError:nil errorString:@"Cererea nu a putut fi confirmata. Va recomandam sa reincarcati evenimentul."];
    }
}


-(void) onUnjoinAgenda:(long)agendaId row:(NSInteger)row{
    _row = row;
    [self startLoading:@"Se confirma cererea ..."];
    AgendasCom* req = [[AgendasCom alloc] init];
    req.delegate = self;
    [req unjoinAgenda:agendaId];
}

-(void) onUnJoinedAgenda:(BOOL)success agendaId:(long)agendaId error:(NSError *)e{
    [self stopLoading];
    if(success)
    {
        TVAgendaCell* cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_row inSection:0]];
        Agenda* a = [Agenda getAgenda:cell.agendaId];
        if(a.availablePlaces != nil)
            a.availablePlaces = [NSNumber numberWithLong:[a.availablePlaces longValue] + 1];
        a.joined = [NSNumber numberWithBool:NO];
        [cell setAgenda:a row:_row];
    }
    else{
        [RU showRedError:nil errorString:@"Cererea nu a putut fi confirmata. Va recomandam sa reincarcati evenimentul."];
    }

}

-(void) onRefreshPressed{
    _event.lastUpdated = nil;
    [DB save];
    [self loadEvent];
}

-(BOOL) slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

-(void)setupCollectionView
{
    [_collectionViewDays registerNib:[UINib nibWithNibName:@"CVDayCell" bundle:nil] forCellWithReuseIdentifier:@"dayCell"];
    _collectionViewDays.contentInset = UIEdgeInsetsZero;
    _collectionViewDays.dataSource = self;
    _collectionViewDays.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void) onDownloadFile:(int)total step:(int)step fileName:(NSString *)fileName{
    [self startLoading:[NSString stringWithFormat:@"Fisiere : %d/%d",step,total]];
}

-(void) onBeaconsReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
     [self startLoading:@"Fisiere..."];
}

-(void) onAllAgendasReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
    [self startLoading:@"Devices..."];
}


-(void) onLocationsReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
     [self startLoading:@"Program..."];
}

-(void) onOrganizersReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err{
    [self startLoading:@"Participanti..."];
}

-(void) onParticipantsReceived:(BOOL)success eventId:(long)eventId error:(NSError *)err
{
    [self startLoading:@"Locatii..."];
}



-(void) loadEvent{
    if(_event == nil)
        return;
    if(_event.unique == nil)
        return;
    if(_event.lastUpdated == nil)
    {
        [self startLoading:@"Organizatori"];
        _req = [[EventsCom alloc] init];
        _req.delegate = self;
        _req.downloadDelegate = self;
        _event.lastUpdated = nil;
        [DB save];
        [_req getEventData:[_event.unique longValue]];
    }
    else{
        _days = [Event getDaysForEvent:_event];
        [_tableView reloadData];
        if (_days.count > 1) [self reloadTableForDay:_days[0]];
        
        [_collectionViewDays reloadData];
    }
    
}

-(void) onEventDataReceived:(BOOL)success response:(long)eventId error:(NSError *)err
{
    if(success)
    {
        [self stopLoading];
    }
    if (err) {
        [self stopLoading];
        NSLog(@"Error !!! %@",err.description);
    }
    
    _days = [Event getDaysForEvent:_event];
    _event.lastUpdated = [NSDate date];
    [DB save];
    if (_days.count > 1) [self reloadTableForDay:_days[0]];
   
    [_collectionViewDays reloadData];
}

#pragma TableView data & delegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [agendas count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVAgendaCell* c = [tableView dequeueReusableCellWithIdentifier:@"agendaCell"];
    
    Agenda* ag = agendas[indexPath.row];
    [c setAgenda:ag row:indexPath.row];
    
    c.isExpanded = [expandedIndexPaths containsObject:indexPath];
    c.delegate = self;
    
    return c;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    agenda = agendas[indexPath.row];
    
    if ([expandedIndexPaths containsObject:indexPath]) {
        [expandedIndexPaths removeObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        [expandedIndexPaths addObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
//    idxPath = indexPath;
//    
//    TVAgendaCell* cell =[_tableView cellForRowAtIndexPath:indexPath];
//    
//    if([idxPath isEqual:indexPath])
//    {
//        //cell.viewExpanded.hidden = YES;
//        idxPath = [NSIndexPath indexPathForRow:-1 inSection:0];
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        return;
//    }
//    
//    //First we check if a cell is already expanded.
//    //If it is we want to minimize make sure it is reloaded to minimize it back
//    if(idxPath.row >= 0)
//    {
//        
//        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:idxPath.row inSection:0];
//        TVAgendaCell* cell =[_tableView cellForRowAtIndexPath:idxPath];
//        cell.viewExpanded.hidden = YES;
//        //selectedIndex = (int)indexPath.row;
//        idxPath = indexPath;
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    
//    //cell.viewExpanded.hidden= NO;
//    //Finally set the selected index to the new selection and reload it to expand
//    //selectedIndex = (int)indexPath.row;
//    idxPath = indexPath;
//    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}



#pragma mark CollectionView data & delegate

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return _days.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CVDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell"
                                      forIndexPath:indexPath];
    DayAgendas* dAgenda = _days[indexPath.row];
   
    cell.labelDate.text = [DUtils getDayStringPrettyPrinted:dAgenda.day];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DayAgendas* da = _days[indexPath.row];
    
    [self reloadTableForDay:da];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 55);
}


-(void)reloadTableForDay:(DayAgendas*)dAgenda
{
    agendas = [dAgenda getAgendasForDay:dAgenda.day];
    [_tableView reloadData];
}


-(void)didPressBtnMore:(NSNotification*)n
{
    ScheduleDetailVC* vc = (ScheduleDetailVC*)[GU getController:@"Events" identifier:@"ScheduleDetailVC"];
    
    vc.agenda = agenda;
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (IBAction)didChangeAgenda:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 1) {
        _days = [Event getMyDaysForEvent:_event];
        if (_days.count > 1) [self reloadTableForDay:_days[0]];
        [_collectionViewDays reloadData];
    }
    else {
        _days = [Event getDaysForEvent:_event];
        _event.lastUpdated = [NSDate date];
        if (_days.count > 1) [self reloadTableForDay:_days[0]];
        
        [_collectionViewDays reloadData];
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
