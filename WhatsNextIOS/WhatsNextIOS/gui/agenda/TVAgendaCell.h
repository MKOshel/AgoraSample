//
//  TVAgendaCell.h
//  WhatsNextIOS
//
//  Created by Dragos on 17/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agenda.h"

@protocol AgendaCellDelegate <NSObject>

@optional
-(void) onJoinAgenda:(long) agendaId row:(NSInteger) row;
-(void) onUnjoinAgenda:(long) agendaId row:(NSInteger) row;

@end

@interface TVAgendaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelHours;
@property (weak, nonatomic) IBOutlet UILabel *labelDescr;
@property (strong, nonatomic) IBOutlet UILabel *labelSpeakers;
@property (strong, nonatomic) IBOutlet UILabel *labelParticipants;
@property (strong, nonatomic) IBOutlet UIButton *btnJoin;
@property (weak, nonatomic) IBOutlet UIView *viewExpanded;
-(void) setAgenda:(Agenda*) ag row:(NSInteger) row;
@property (weak, nonatomic) IBOutlet UILabel *labelLocuri;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UILabel *labelParticipa;
@property(nonatomic, readwrite) long agendaId;
@property(nonatomic, readwrite) NSInteger row;
@property(nonatomic, weak)id<AgendaCellDelegate> delegate;
@property(nonatomic, assign) BOOL isExpanded;
@end
