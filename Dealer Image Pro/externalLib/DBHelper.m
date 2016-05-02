//
//  DBHelper.m
//  CoreDataTest
//
//  Created by Danish Khan on 10/6/10.
//  Copyright 2010 DevLab. All rights reserved.
//

#import "DBHelper.h"
#import "AppDelegate.h"


@implementation DBHelper

AppDelegate *appDelegate;

@synthesize dateFormatter = _dateFormatter;

-(id) init {
    
    if((self = [super init]))
    {
        appDelegate = [AppDelegate sharedAppDelegate];
        //[self initializeDateFormatter];
    }
    return self;
}

+ (DBHelper *)sharedDBHelper
{
    static DBHelper *objDBHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objDBHelper = [[DBHelper alloc] init];
    });
    return objDBHelper;
}

- (void)initializeDateFormatter
{
    if (!self.dateFormatter)
    {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
}

- (NSDate *)dateUsingStringFromAPI:(NSString *)dateString {
    [self initializeDateFormatter];
    // NSDateFormatter does not like ISO 8601 so strip the milliseconds and timezone
    dateString = [dateString substringWithRange:NSMakeRange(0, [dateString length]-5)];
    
    return [self.dateFormatter dateFromString:dateString];
}

- (NSString *)dateStringForAPIUsingDate:(NSDate *)date
{
    [self initializeDateFormatter];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    // remove Z
    dateString = [dateString substringWithRange:NSMakeRange(0, [dateString length]-1)];
    // add milliseconds and put Z back on
    dateString = [dateString stringByAppendingFormat:@".000Z"];
    
    return dateString;
}


-(NSEntityDescription *)getEnitityFor:(NSString *)strEntity inManagedObjectContext:(NSManagedObjectContext *)moc
{
    if (moc == nil)
    {
        moc = appDelegate.managedObjectContext;
    }
    
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:strEntity
                                                                inManagedObjectContext:moc];
    
    return entity;
}

-(void)deleteObject:(NSManagedObject *)managedObject
{
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    [moc deleteObject:managedObject];
    [appDelegate saveContext];
}

#pragma -
#pragma Fetching Libs
-(NSManagedObject *) getObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)moc
{
    if (moc == nil)
    {
        moc = appDelegate.managedObjectContext;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    [fetchRequest setFetchLimit:1.0];
    [fetchRequest setPredicate:predicate];
    NSArray *arr = (NSArray *) [moc executeFetchRequest:fetchRequest error:&error];
   // [fetchRequest release];
    
    return ([arr count] > 0) ? [arr objectAtIndex:0] : nil ;
}

-(NSManagedObject *) getObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    [fetchRequest setFetchLimit:1.0];
    if(predicate){
        [fetchRequest setPredicate:predicate];
    }
    NSArray *arr = (NSArray *) [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
   // [fetchRequest release];
    if([arr count] > 1){
        NSManagedObject *managedObject = [arr lastObject];
        [appDelegate.managedObjectContext deleteObject:managedObject];
    }
    return ([arr count] > 0) ? [arr objectAtIndex:0] : nil ;
}

-(NSMutableArray *) getObjectsforEntityForUpdate:(NSString *)strEntity
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    [fetchRequest setFetchLimit:1.0];
    NSMutableArray *arr =  (NSMutableArray *) [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //[fetchRequest release];
    
    return ([arr count] > 0) ? arr : nil ;
}


-(NSManagedObject *) getObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate ShortBy:(NSString *)strShort isAscending:(BOOL)asc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:strShort ascending:asc];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    //[sort release];
    
    NSError *error;
    [fetchRequest setFetchLimit:1.0];
    [fetchRequest setPredicate:predicate];
    NSArray *arr = (NSArray *) [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
   // [fetchRequest release];
    
    return ([arr count] > 0) ? [arr objectAtIndex:0] : nil ;
}

-(NSMutableArray*) getObjectsforEntity:(NSString *)strEntity
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSMutableArray *arrPatients = (NSMutableArray*)[appDelegate.managedObjectContext
                                                    executeFetchRequest:fetchRequest error:&error];
	//[arrPatients retain];
    
   // [fetchRequest release];
    
    return arrPatients;
}

-(NSMutableArray*) getObjectsforEntity:(NSString *)strEntity ShortBy:(NSString *)strShort isAscending:(BOOL)ascending
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];

    [fetchRequest setIncludesPendingChanges:NO]; // DONT INCLUDE THE UNSAVED CHANGES...

    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:strShort ascending:ascending];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
   // [sort release];
    
    NSError *error;
    NSMutableArray *arrPatients = (NSMutableArray*)[appDelegate.managedObjectContext
                                                    executeFetchRequest:fetchRequest error:&error];
	//[arrPatients retain];
    
   // [fetchRequest release];
    
    return arrPatients;
}

#pragma -
#pragma Fetching Libs
-(NSMutableArray*) getObjectsforEntity:(NSString *)strEntity ShortBy:(NSString *)strShort isAscending:(BOOL)ascending predicate:(NSPredicate *)predicate
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    

    [fetchRequest setIncludesPendingChanges:NO];
    
    if (strShort) {
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:strShort ascending:ascending];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
       // [sort release];
    }
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
        
    NSError *error = nil;
    NSMutableArray *arrData = (NSMutableArray*)[appDelegate.managedObjectContext
                                                    executeFetchRequest:fetchRequest error:&error];
	//[arrData retain];
    
    if (error != nil)
    {
        NSLog(@"Fetch Request Error :%@",error);
    }
    return arrData;
}

-(NSMutableArray*)getFeedEntitiyforMostResent:(NSInteger )pageNo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    [fetchRequest setIncludesPendingChanges:NO];
    
    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc] initWithKey:@"shortDate" ascending:YES];
    //NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:FIELD_DISTANCE ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort1 , nil]];
    
   // fetchRequest.fetchOffset = (pageNo-1) * LOCAL_PAGE_LIMIT;
  //  fetchRequest.fetchLimit = LOCAL_PAGE_LIMIT;
    
    //[sort1 release];
   // [sort2 release];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"videoType = %@", MOST_RESENDT_VIDEO];
   // [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *arrData = (NSMutableArray*)[appDelegate.managedObjectContext
                                                executeFetchRequest:fetchRequest error:&error];
    //[arrData retain];
    
    if (error != nil)
    {
        NSLog(@"Fetch Request Error :%@",error);
    }
    return arrData;
}

-(NSMutableArray*)getFeedEntitiyforMostVoted:(NSInteger )pageNo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    [fetchRequest setIncludesPendingChanges:NO];
    
    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc] initWithKey:@"shortDate" ascending:YES];
    //NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:FIELD_DISTANCE ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort1, nil]];
    
//    fetchRequest.fetchOffset = (pageNo-1) * LOCAL_PAGE_LIMIT;
//    fetchRequest.fetchLimit = LOCAL_PAGE_LIMIT;
//    [sort1 release];
    //[sort2 release];
    
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"videoType = %@", MOST_VOTED_VIDEO];
   // [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *arrData = (NSMutableArray*)[appDelegate.managedObjectContext
                                                executeFetchRequest:fetchRequest error:&error];
   // [arrData retain];
    
    if (error != nil)
    {
        NSLog(@"Fetch Request Error :%@",error);
    }
    return arrData;
}

-(NSMutableArray*)getFeedEntitiyforMyScene:(NSInteger )pageNo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setIncludesPendingChanges:NO];

 //   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"videoType = %@", MY_SCENE];
  //  [fetchRequest setPredicate:predicate];

    //NSSortDescriptor *sort1 = [[NSSortDescriptor alloc] initWithKey:FIELD_CREATED_AT ascending:NO];
    //NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:FIELD_DISTANCE ascending:YES];
   // [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort1, nil]];
    
    //fetchRequest.fetchOffset = (pageNo-1) * LOCAL_PAGE_LIMIT;
   // fetchRequest.fetchLimit = LOCAL_PAGE_LIMIT;
    
    //[sort1 release];
    //[sort2 release];
    
    NSError *error = nil;
    NSMutableArray *arrData = (NSMutableArray*)[appDelegate.managedObjectContext
                                                executeFetchRequest:fetchRequest error:&error];
  //  [arrData retain];
    
    if (error != nil)
    {
        NSLog(@"Fetch Request Error :%@",error);
    }
    return arrData;
}


-(NSMutableArray*)getFeedEntitiyforMyComments:(NSInteger )pageNo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setIncludesPendingChanges:NO];
    
    //NSSortDescriptor *sort1 = [[NSSortDescriptor alloc] initWithKey:FIELD_TOP_VIDEOS ascending:NO];
   // NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:FIELD_DISTANCE ascending:YES];
    //[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort1,sort2, nil]];
    
   // fetchRequest.fetchOffset = (pageNo-1) * LOCAL_PAGE_LIMIT;
   // fetchRequest.fetchLimit = LOCAL_PAGE_LIMIT;
    
   // [sort1 release];
   // [sort2 release];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"videoType = %@", MY_COMMENT];
    //[fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *arrData = (NSMutableArray*)[appDelegate.managedObjectContext
                                                executeFetchRequest:fetchRequest error:&error];
    //[arrData retain];
    
    if (error != nil)
    {
        NSLog(@"Fetch Request Error :%@",error);
    }
    return arrData;
}





-(NSUInteger) getObjectCountforEntity:(NSString *)strEntity
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSUInteger entityCount = [appDelegate.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    //[fetchRequest release];
    
    return entityCount;
}

-(NSUInteger) getObjectCountforEntity:(NSString *)strEntity withPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    NSUInteger entityCount = [appDelegate.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    //[fetchRequest release];
    
    return entityCount;
}

-(void) deleteObjectsForEntity:(NSString *)strEntity
{
	NSManagedObjectContext *moc = appDelegate.managedObjectContext;
	
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	NSArray *Result;
	NSError *error;

	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	
	Result = [moc executeFetchRequest:fetchRequest error:nil];
    
	for (NSManagedObject *managedObject in Result) {
        
        [moc deleteObject:managedObject];
    }
    
	error = nil;
	[moc save:&error];
}

-(void) deleteObjectsForEntity:(NSString *)strEntity withPredicate:(NSPredicate *)predicate
{
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;
    NSArray *Result;
    NSError *error;
    
    fetchRequest = [[NSFetchRequest alloc] init];
    
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    Result = [moc executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *managedObject in Result) {
        
        [moc deleteObject:managedObject];
    }
    
    error = nil;
    [moc save:&error];
}

-(void)DeleteObjectForObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    [fetchRequest setFetchLimit:1.0];
    if(predicate){
        [fetchRequest setPredicate:predicate];
    }
    NSArray *arr = (NSArray *) [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //[fetchRequest release];
    if([arr count] > 0){
        for(NSManagedObject *managedObject in arr){
            [appDelegate.managedObjectContext deleteObject:managedObject];
        }
    }

}

/*
-(void)createOrReplaceObjectToCoreData:(NSDictionary *)dict forEntity:(NSString *)strEntityName withvidType:(NSString *)vidType
{
   
    if([strEntityName isEqualToString:@""]){
        
        NSPredicate *vidPredicate = [NSPredicate predicateWithFormat:@"videoId = %@",[dict objectForKey:@"videoId"]];
        
        NSLog(@"VID ID :::::::::: %@ ",[dict objectForKey:@"videoId"]);
        
        VideoFeed *feedObj= nil;
        feedObj = (VideoFeed *)[self getObjectforEntity:ENTITY_FEED predicate:vidPredicate];
       // [self DeleteObjectForObjectforEntity:ENTITY_FEED predicate:vidPredicate];
        
        if(feedObj != nil){

            feedObj.videoComments = [self getNumberFromString:[dict objectForKey:@"videoComments"]];
            feedObj.videoVotes = [self getNumberFromString:[dict objectForKey:@"videoVotes"]];
            feedObj.videoCreatedAt= [self getDateFromString:[dict objectForKey:@"videoCreatedAt"]];
            feedObj.shortDate = [NSDate date];
            if([vidType isEqualToString:SEARCH_VIDEO]){
                feedObj.distance      = 0;
            }else{
                if([[dict objectForKey:@"distance"] isKindOfClass:[NSNull class]]){
                    feedObj.distance = 0;
                }else{
                    feedObj.distance      = [self getNumberFromString:[dict objectForKey:@"distance"]] ;
                }
            }
            feedObj.videoType = vidType;

            
            //NSLog(@"UPDATED ID::::::<<<<<<");
            [[AppDelegate sharedAppDelegate]saveContext];

        }else {
            
            VideoFeed *objFeed = (VideoFeed *)[[DBHelper sharedDBHelper] getEnitityFor:ENTITY_FEED inManagedObjectContext:nil];
            
            //NSLog(@"INSERTED ID:::::: ID :%@ DIS : %@<<<<<<", [dict objectForKey:@"videoId"] ,[dict objectForKey:@"distance"] );
            
            objFeed.videoId = [dict objectForKey:@"videoId"];
            objFeed.vendorId =[dict objectForKey:@"vendorId"];
            
            objFeed.videoTitle    = [dict objectForKey:@"videoTitle"];
            objFeed.videoImage    = [dict objectForKey:@"videoImage"];
            objFeed.videoUrl      = [dict objectForKey:@"videoUrl"];
            
            objFeed.videoLatitude = [dict objectForKey:@"videoLatitude"];
            objFeed.videoLongitude= [dict objectForKey:@"videoLongitude"];
            objFeed.videoCreatedAt= [self getDateFromString:[dict objectForKey:@"videoCreatedAt"]];
            
            objFeed.videoComments = [self getNumberFromString:[dict objectForKey:@"videoComments"]];
            objFeed.videoVotes    = [self getNumberFromString:[dict objectForKey:@"videoVotes"]];
            objFeed.videoType = vidType;
            objFeed.shortDate = [NSDate date];
            if([vidType isEqualToString:SEARCH_VIDEO]){
               objFeed.distance      = 0;
            }else{
                if([[dict objectForKey:@"distance"] isKindOfClass:[NSNull class]]){
                    objFeed.distance = 0;
                }else{
                    objFeed.distance      = [self getNumberFromString:[dict objectForKey:@"distance"]] ;
                }
            }
            
            
            [[AppDelegate sharedAppDelegate]saveContext];
        }
    }
} */


-(NSNumber *)getNumberFromString:(NSString *)string
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    return [format numberFromString:string];
}

-(NSDate *)getDateFromString:(NSString *)strdate
{
    NSString* format = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter* formatterUtc = [[NSDateFormatter alloc] init];
    [formatterUtc setDateFormat:format];
    [formatterUtc setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate* utcDate = [formatterUtc dateFromString:strdate];
    
    NSDateFormatter* formatterLocal = [[NSDateFormatter alloc] init];
    [formatterLocal setDateFormat:format];
    [formatterLocal setTimeZone:[NSTimeZone localTimeZone]];
    
    return [formatterUtc dateFromString:[formatterLocal stringFromDate:utcDate]];
}


//-(NSArray *)getShortListByKey:(NSString *)strKey
//{
//    NSString *documentsDirectory = [appDelegate applicationDocumentDirectoryString];
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ShortingList.plist"];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    
//    return [dict objectForKey:strKey];
//}


@end