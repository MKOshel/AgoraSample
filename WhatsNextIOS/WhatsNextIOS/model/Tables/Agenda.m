//
//  Agenda.m
//  
//
//  Created by dragos on 5/9/16.
//
//

#import "Agenda.h"
#import "Event.h"
#import "Question.h"
#import "User.h"
#import "Location.h"
#import "Attachment.h"

@implementation Agenda

// Insert code here to add functionality to your managed object subclass

+(Agenda*) getCurrentAgendaForLocation:(Location *)location{
    
    if(location == nil)
        return nil;
    NSLog(@"location = %@",location.name);
    NSLog(@"b.location.id = %@",location.unique);
    NSDate* d = [NSDate date];
    NSPredicate* p =[NSPredicate predicateWithFormat:@"location.unique = %@ and ((startTime > %@) or (startTime < %@ and endTime > %@))",location.unique, d,d,d];
    NSArray* arr = [Agenda MR_findAllSortedBy:@"startTime" ascending:YES withPredicate:p];
    if(arr == nil || [arr count] == 0)
        return nil;
    return [arr objectAtIndex:0];
}

+(NSArray*) getAgendasForEvent:(long) eventId{
    //NSArray* arr = [Agenda MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"event.unique = %@",[NSNumber numberWithLong:eventId]]];
    NSArray* arr = [ Agenda MR_findAllSortedBy:@"startTime" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"event.unique = %@",[NSNumber numberWithLong:eventId]]];
    return arr;
}

+(NSArray*) getMyAgendasForEvent:(long) eventId{
    NSArray* arr = [ Agenda MR_findAllSortedBy:@"startTime" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"event.unique = %@ and (mandatory = %@ or joined = %@)",[NSNumber numberWithLong:eventId],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]]];
    return arr;

}

-(NSString*) getDayString{
    return [RU getDayString:self.startTime];
}

+(void) deleteAgendasForEvent:(long) eventId{
    NSArray* arr = [Agenda getAgendasForEvent:eventId];
    for(int i = 0 ; i < [arr count] ; i++)
    {
        Agenda* a = [arr objectAtIndex:i];
        for(Attachment* at in a.attachments)
        {
            [at deleteFile];
            [at MR_deleteEntity];
        }        
        [a MR_deleteEntity];
    }
    [DB save];
}


-(NSString*) getSpeakerNames{
    NSString* speakers = @"";
    if([self.speakers count])
    {
        NSArray* arr = [self.speakers allObjects];
        User* u = [arr objectAtIndex:0];
        speakers = u.name;
        for(int i = 1 ; i < [arr count] ; i++)
        {
            User* u = [arr objectAtIndex:i];
            speakers = [speakers stringByAppendingString:[NSString stringWithFormat:@",%@",u.name]];
        }
    }
    return speakers;
}

+(void) parseMyAgendas:(NSArray *)ids{
    for(int i = 0 ; i < [ids count] ; i++)
    {
        NSNumber* n = [ids objectAtIndex:i];
        long unique = [n longValue];
        Agenda* a = [Agenda getAgenda:unique];
        if(a != nil)
        {
            a.joined = [NSNumber numberWithBool:YES];
        }
    }
    [DB save];
}

+(void) parseMandatoryAgendas:(NSArray *)ids{
    for(int i = 0 ; i < [ids count] ; i++)
    {
        NSNumber* n = [ids objectAtIndex:i];
        long unique = [n longValue];
        Agenda* a = [Agenda getAgenda:unique];
        if(a != nil)
        {
            a.mandatory = [NSNumber numberWithBool:YES];
        }
    }
    [DB save];
}

+(NSMutableArray*) parseAgendas:(NSArray *)agendas forEvent:(Event*) event{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    [Agenda deleteAgendasForEvent:[event.unique longValue]];
    if(agendas == nil)
        return arr;
    if([agendas count] == 0)
        return arr;
    for(int i = 0 ; i < [agendas count] ; i++)
    {
        NSDictionary* d = (NSDictionary*)[agendas objectAtIndex:i];
        Agenda* a = [Agenda parserAgenda:d];
        if(!a)
            continue;
        a.event = event;
        if(a.location != nil)
            a.location.event = event;
        //parse agenda
        [arr addObject:a];
        [DB save];
    }
    return arr;
}

+(Agenda*) parserAgenda:(NSDictionary*)d{
    
    
    NSString* address = [RU gs:[d objectForKey:@"address"]];
    NSString* agendaType = [RU gs:[d objectForKey:@"agendaType"]];
    NSNumber* availablePlaces = [RU gn:[d objectForKey:@"availablePlaces"]];
    NSString* description = [RU gs:[d objectForKey:@"description"]];
    NSString* name = [RU gs:[d objectForKey:@"name"]];
    NSNumber* mandatory = [RU gb:[d objectForKey:@"mandatory"]];
    NSNumber* joined = [RU gb:[d objectForKey:@"joined"]];
    NSString* sala = [RU gs:[d objectForKey:@"meetingRoom"]];
    NSNumber* unique = [RU gn:[d objectForKey:@"id"]];
    NSDate* startDate = [RU gd:[d objectForKey:@"startTime"]];
    NSDate* endDate = [RU gd:[d objectForKey:@"endDate"]];
    NSDictionary* dLocation = [d objectForKey:@"location"];
    NSArray* dSpeakers = [d objectForKey:@"speakers"];
    
    
    Location* l = nil;
    if([dLocation isKindOfClass:[NSDictionary class]])
    {
        l = [Location parseLocation:dLocation];
    }
    
    Agenda* a = nil;
    a = [Agenda getAgenda:[unique longValue]];
    if(a == nil)
        a = [Agenda MR_createEntity];
    NSSet* set = [[NSSet alloc] init];
    if(dSpeakers != nil && [dSpeakers count])
    {
        for(int i = 0 ; i < [dSpeakers count] ; i++)
        {
            NSDictionary* d = [dSpeakers objectAtIndex:i];
            User* u = [User parseUser:d];
            if(u)
                set = [set setByAddingObject:u];
        }
    }
    a.speakers = set;
    
    
    a.unique = unique;
    a.user = [SM getCurrentUser];
    a.address = address;
    a.agendaType = agendaType;
    a.availablePlaces = availablePlaces;
    a.descr = description;
    a.name = name;
    a.mandatory = mandatory;
    a.joined = joined;
    a.startTime = startDate;
    a.location = l;
    a.endTime = endDate;
    
    return a;
}

+(Agenda*) getAgenda:(long) unique{
    return [Agenda MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"unique = %@",[NSNumber numberWithLong:unique]]];
}

@end
