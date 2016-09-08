//
//  DetailCell.h
//  WhatsNextIOS
//
//  Created by Dragos on 19/05/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelSpeakers;
@property (weak, nonatomic) IBOutlet UILabel *labelDescr;
@property (weak, nonatomic) IBOutlet UILabel *labelSeatsNumber;

@end
