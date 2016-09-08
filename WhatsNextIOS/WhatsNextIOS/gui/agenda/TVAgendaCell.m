//
//  TVAgendaCell.m
//  WhatsNextIOS
//
//  Created by Dragos on 17/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "TVAgendaCell.h"
#import "ScheduleViewController.h"
#import "Location.h"
@interface TVAgendaCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewExpandedHeightConstraint;

@end
@implementation TVAgendaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self customize];
    
    [_btnMore addTarget:self action:@selector(didPressBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    [_btnJoin addTarget:self action:@selector(didPressBtnJoin:) forControlEvents:UIControlEventTouchUpInside];
    _isExpanded = NO;
    _viewExpandedHeightConstraint.constant = 0;
}


-(void)setIsExpanded:(BOOL)isExpanded
{
    _isExpanded = isExpanded;
    if (isExpanded) {
        _viewExpandedHeightConstraint.priority = 250;

    }
    else {
        _viewExpandedHeightConstraint.priority = 999;

    }
    
}
-(void) setAgenda:(Agenda*) ag row:(NSInteger)row{
    _row = row;
     NSString* time = [NSString stringWithFormat:@"%@-%@",[RdUtils getTimeString:ag.startTime],[RdUtils getTimeString:ag.endTime]];
    
    NSString* sala = @"";
    
    if(ag.location != nil)
    {
        sala = [NSString stringWithFormat:@"%@",ag.location.name];
        time = [time stringByAppendingString:[NSString stringWithFormat:@" - %@",sala]];
    }
    NSString* speakers = [ag getSpeakerNames];
    NSString* type = ag.agendaType;
    
    self.imgView.image = [GU image:[UIImage imageNamed:[NSString stringWithFormat:@"ic_%@",[type lowercaseString]]] scaledToSize:CGSizeMake(40.0, 40.0)];
    self.labelSpeakers.text = speakers;
    self.labelTitle.text = ag.name;
    self.labelHours.text = time;
    self.labelDescr.text = ag.descr;
    _labelLocuri.textColor = RGB(yellow0);
    _labelParticipa.textColor = RGB(yellow0);
    [_btnJoin setSelected:[ag.joined boolValue]];
    
    
    NSLog(@"%@",ag.name);
    NSLog(@"%ld",[ag.availablePlaces longValue]);
    if([ag.mandatory boolValue] || ag.availablePlaces == nil  || [ag.availablePlaces longValue] == 0)
    {
        _btnJoin.hidden = YES;
        _labelParticipa.hidden = YES;
    }
    else
    {
        _btnJoin.hidden = NO;
        _labelParticipa.hidden = NO;

    }
    
    if([ag.availablePlaces longValue])
    {
        _labelLocuri.hidden = NO;
        _labelParticipants.hidden = NO;
        _labelParticipants.text = [NSString stringWithFormat:@"%ld",[ag.availablePlaces longValue]];
    }
    else
    {
        _labelLocuri.hidden = YES;
        _labelParticipants.hidden = YES;
    }
    if(![RM isAuthenticated])
    {
        _labelParticipa.hidden = YES;
        _btnJoin.hidden = YES;
    }
    _agendaId = [ag.unique longValue];
    
}

-(void)customize
{
    self.backgroundColor = [UIColor clearColor];
    self.labelTitle.textColor = RGB(yellow0);
    self.labelHours.textColor = RGB(yellow0);
    self.labelDescr.textColor = RGB(yellow0);
    self.labelSpeakers.textColor = RGB(yellow0);
    self.viewExpanded.backgroundColor = [UIColor clearColor];
    self.labelParticipants.textColor = RGB(yellow0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_btnJoin setImage:[UIImage imageNamed:@"checkbox_filled"] forState:UIControlStateSelected | UIControlStateHighlighted];
    
}

-(void)didPressBtnMore:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"morePressed" object:nil];
}


-(void)didPressBtnJoin:(UIButton*)sender
{
    if(![RU hasInternet])
    {
        [RU showRedError:nil errorString:@"Nu exista conectivitate la internet"];
        return;
    }

    if(sender.selected)
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(onUnjoinAgenda:row:)])
        {
            [self.delegate onUnjoinAgenda:_agendaId row:_row];
        }
    }
    else
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(onJoinAgenda:row:)])
        {
            [self.delegate onJoinAgenda:_agendaId row:_row];
        }
    }
    //[sender setSelected:!sender.selected];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"joinPressed" object:nil];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
