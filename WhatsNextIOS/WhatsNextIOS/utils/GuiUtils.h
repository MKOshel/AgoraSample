//
//  GuiUtils.h
//  RoadVikings
//
//  Created by dragos on 3/11/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GuiUtils : NSObject


+(void) showViewController:(UIViewController*) ctrl;
+(UIViewController*) initViewController:(NSString*) identifier;
+(CGFloat)measureHeightOfUITextView:(UITextView *)textView;
+(void) resetNavigationBar:(UINavigationController*) navigationController;
+(void) makeTransparentNavigationBar:(UINavigationController*) navigationController;
+(void) setNavigationBarColor:(UINavigationController*) navigationController color:(UIColor*) color;
+(UIColor*) getColor:(double) grade;
+(UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size;
+(void) setPlaceholderColor:(UITextField*) textField color:(UIColor*) color text:(NSString*) text;
+(UIViewController*) getTopViewController;
+(UIViewController*) getController:(NSString*) storyboard identifier:(NSString*) identifier;

@end
