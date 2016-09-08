//
//  ScheduleDetailVC.h
//  WhatsNextIOS
//
//  Created by Dragos on 18/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "BaseViewController.h"
#import "Agenda.h"
#import "MIResizableTableView.h"

@interface ScheduleDetailVC : BaseViewController <MIResizableTableViewDataSource,MIResizableTableViewDelegate,UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelAgendaName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) Agenda* agenda;
@property (weak, nonatomic) IBOutlet MIResizableTableView *tableView;
@property(nonatomic, retain) NSArray* attachments;
@end
