//
//  DatabaseManager.m
//  RoadVikings
//
//  Created by dragos on 3/14/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+(NSManagedObjectContext*) getContext{
    if([NSThread isMainThread])
    {
        return [NSManagedObjectContext MR_defaultContext];
    }
    else{
        return [NSManagedObjectContext MR_rootSavingContext];
        //NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]];
        //return localContext;
    }
}

+(void) save{
    [[DatabaseManager getContext] MR_saveToPersistentStoreAndWait];
}



@end
