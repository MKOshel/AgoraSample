//
//  BaseViewController.m
//  RoadVikings
//
//  Created by dragos on 4/12/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "BaseViewController.h"
#import "SwiftSpinner-Swift.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.view addSubview:_amazingLoadingView];
    // Do any additional setup after loading the view.
}

-(void) startLoading{
    [SwiftSpinner show:@"Se incarca ..." animated:YES];
    /*_amazingLoadingView = [[XHAmazingLoadingView alloc] initWithType:XHAmazingLoadingAnimationTypeMusic];
    _amazingLoadingView.loadingTintColor = [UIColor redColor];
    _amazingLoadingView.backgroundTintColor = [UIColor whiteColor];
    _amazingLoadingView.frame = self.view.bounds;

    [_amazingLoadingView startAnimating];*/
}

-(void) startLoading:(NSString*) message{
    [SwiftSpinner show:message animated:YES];
    /*_amazingLoadingView = [[XHAmazingLoadingView alloc] initWithType:XHAmazingLoadingAnimationTypeMusic];
     _amazingLoadingView.loadingTintColor = [UIColor redColor];
     _amazingLoadingView.backgroundTintColor = [UIColor whiteColor];
     _amazingLoadingView.frame = self.view.bounds;
     
     [_amazingLoadingView startAnimating];*/
}

-(void) stopLoading{
    [SwiftSpinner hide:^{
        
    }];
    //[_amazingLoadingView stopAnimating];
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
