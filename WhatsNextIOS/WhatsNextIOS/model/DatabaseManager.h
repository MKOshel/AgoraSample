//
//  DatabaseManager.h
//  RoadVikings
//
//  Created by dragos on 3/14/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject


+(NSManagedObjectContext*) getContext;

+(void) save;

@end
