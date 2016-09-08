//
//  BaseViewController.h
//  RoadVikings
//
//  Created by dragos on 4/12/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHAmazingLoadingView.h"


@interface BaseViewController : UIViewController

@property(nonatomic, retain) XHAmazingLoadingView *amazingLoadingView;

-(void) startLoading;

-(void) stopLoading;

-(void) startLoading:(NSString*) message;


@end
