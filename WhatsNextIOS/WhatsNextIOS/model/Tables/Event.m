//
//  Event.m
//  
//
//  Created by dragos on 5/9/16.
//
//

#import "Event.h"
#import "Question.h"
#import "User.h"
#import "Agenda.h"
#import "DayAgendas.h"
#import "Attachment.h"
#import "Location.h"

@implementation Event

// Insert code here to add functionality to your managed object subclass

+(NSArray*)getEvents
{
    return [Event MR_findAllSortedBy:@"startDate" ascending:NO];
}

+(Event*) getEvent:(long) unique{
    return [Event MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unique = %@",[NSNumber numberWithLong:unique]]];
}

+(NSArray*) getPrivateEvents{
     NSArray* arr = [Event MR_findAllSortedBy:@"startDate" ascending:NO withPredicate:[NSPredicate predicateWithFormat:@"privacy = %@",[NSNumber numberWithBool:NO]]];
    return arr;
}

+(NSArray*) getPublicEvents{
    NSArray* arr = [Event MR_findAllSortedBy:@"startDate" ascending:NO withPredicate:[NSPredicate predicateWithFormat:@"privacy = %@",[NSNumber numberWithBool:NO]]];

    return arr;
}


+(void) deletePrivateEvents{
    NSArray* arr = [Event getPrivateEvents];
    for(int i = 0 ; i < [arr count] ; i++)
    {
        Event* e = [arr objectAtIndex:i];
        [Event deleteEvent:[e.unique longValue]];
    }
}

-(void) deleteEventData{
    long eventId = [self.unique longValue];
    [Agenda deleteAgendasForEvent:eventId];
    [Location deleteLocationsForEvent:eventId];
    [User deleteUsersForEvent:eventId];
}

+(void) deleteEvent:(long) eventId{
    Event* e = [Event getEvent:eventId];
    [e deleteEventData];
    
    if(e)
       [e MR_deleteEntity];
}

+(NSArray*) getOrganizersForEvent:(long)eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return nil;
    NSArray* arr = [User MR_findAllSortedBy:@"firstName" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"any eventsOrganizer contains[c] %@",e]];
    return arr;
}

+(NSArray*) getParticipantsForEvent:(long)eventId{
    Event* e = [Event getEvent:eventId];
    if(e == nil)
        return nil;
    NSArray* arr = [User MR_findAllSortedBy:@"firstName" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"any eventsParticipant contains[c] %@",e]];
    return arr;
}

+(NSMutableArray*) getMyDaysForEvent:(Event*) event{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    NSArray* arrAgendas = [Agenda getMyAgendasForEvent:[event.unique longValue]];
    return [Event groupAgendas:arrAgendas];
}


+(NSMutableArray*) groupAgendas:(NSMutableArray*) arrAgendas{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    if(arrAgendas == nil || [arrAgendas count] == 0)
        return  arr;
    
    Agenda* current = [arrAgendas objectAtIndex:0];
    NSString* lastDate = [current getDayString];
    DayAgendas* da = [[DayAgendas alloc] init];
    [da.agendas addObject:current];
    da.day = current.startTime;
    [arr addObject:da];
    for(int i = 1 ; i < [arrAgendas count] ; i++)
    {
        current = [arrAgendas objectAtIndex:i];
        NSString* cDate = [current getDayString];
        if([cDate isEqualToString:lastDate])
        {
            [da.agendas addObject:current];
        }
        else{
            da = [[DayAgendas alloc] init];
            [da.agendas addObject:current];
            da.day = current.startTime;
            lastDate = [current getDayString];
            [arr addObject:da];
        }
    }
    
    
    return arr;
}

+(NSMutableArray*) getDaysForEvent:(Event*) event
{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    NSArray* arrAgendas = [Agenda getAgendasForEvent:[event.unique longValue]];
    
    return [Event groupAgendas:arrAgendas];
    
}


@end
