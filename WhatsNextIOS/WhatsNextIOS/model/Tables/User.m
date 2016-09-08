//
//  User.m
//  
//
//  Created by dragos on 5/9/16.
//
//

#import "User.h"
#import "Question.h"
#import "Event.h"
#import "Feedback.h"
#import "Agenda.h"

@implementation User

// Insert code here to add functionality to your managed object subclass

+(void) parseOrganizers:(NSArray *)arr eventId:(long)eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return;
    if(arr == nil || [arr count] == 0)
        return;
    
    for(int i = 0 ; i < [arr count] ; i++)
    {
        NSDictionary* d = [arr objectAtIndex:i];
        User* s = [User parseUser:d];
        if(s)
        {
            if(![e.organizers containsObject:s])
                e.organizers = [e.organizers setByAddingObject:s];
        }
        
    }
    
    [DB save];
}


+(void) deleteUsersForEvent:(long)eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return;
    for(User* u in e.participants)
    {
        if(u.eventsParticipant.count == 1)
        {
            [u MR_deleteEntity];
        }
    }
    
    for(User* u in e.organizers)
    {
        if(u.eventsOrganizer.count == 1)
            [u MR_deleteEntity];
    }
}

+(void) parseParticipants:(NSArray *)arr eventId:(long)eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return;
    if(arr == nil || [arr count] == 0)
        return;
    
    for(int i = 0 ; i < [arr count] ; i++)
    {
        NSDictionary* d = [arr objectAtIndex:i];
        User* s = [User parseUser:d];
        if(s)
            if(![e.participants containsObject:s])
                e.participants = [e.participants setByAddingObject:s];
        
    }
    
    [DB save];
}

-(NSString*) name
{
    NSString* firstName = self.firstName?self.firstName:@"";
    NSString* lastName = self.lastName?self.lastName:@"";
    return [NSString stringWithFormat:@"%@ %@",firstName,lastName];
}

+(User*) loginUser:(NSDictionary*)d{
    User* u = [User parseUser:d];
    if(u == nil)
        return nil;
    NSArray* arr = [User MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"loggedIn = %@",[NSNumber numberWithBool:YES]]];
    for(int i = 0 ; i < [arr count] ; i++)
    {
        User* u = [arr objectAtIndex:i];
        u.loggedIn = nil;
    }
    [DB save];
    u.loggedIn = [NSNumber numberWithBool:YES];
    [DB save];
    return u;
}

+(User*) getLoggedInUser{
    NSArray* arr = [User MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"loggedIn = %@",[NSNumber numberWithBool:YES]]];
    if([arr count] == 0)
        return nil;
    return [arr objectAtIndex:0];
}

+(User*) parseUser:(NSDictionary *)d{
    if(d == nil)
        return nil;
    NSNumber* unique = [RU getLong:d key:@"id"];
    if(unique == nil || [unique longValue] == 0)
        return nil;
    NSString* title = [RU getString:d key:@"title"];
    NSString* jobTitle = [RU getString:d key:@"jobTitle"];
    NSString* login = [RU getString:d key:@"login"];
    NSString* phone = [RU getString:d key:@"phone"];
    NSString* firstName = [RU getString:d key:@"firstName"];
    NSString* lastName = [RU getString:d key:@"lastName"];
    NSString* email = [RU getString:d key:@"email"];
    
    User* u = [User getUser:[unique longValue]];
    if( u == nil)
        u = [User MR_createEntity];
    
    u.telefon = phone;
    u.jobTitle = jobTitle;
    u.title = title;
    u.unique = unique;
    u.firstName = firstName;
    u.lastName = lastName;
    u.login = login;
    u.email = email;
    return u;
}

+(User*) getUser:(long) unique{
    return [User MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unique = %@",[NSNumber numberWithLong:unique]]];
}


@end
