//
//  DBHelper.h
//  CoreDataTest
//
//  Created by Danish Khan on 10/6/10.
//  Copyright 2010 DevLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface DBHelper : NSObject
{

}

@property (nonatomic, strong) NSDateFormatter *dateFormatter;


-(NSManagedObject *) getObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate;
-(NSManagedObject *) getObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate ShortBy:(NSString *)strShort isAscending:(BOOL)asc;

-(NSEntityDescription *)getEnitityFor:(NSString *)strEntity inManagedObjectContext:(NSManagedObjectContext *)moc;
-(NSManagedObject *) getObjectforEntity:(NSString *)strEntity predicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)moc;

-(NSMutableArray*) getObjectsforEntity:(NSString *)strEntity;
-(NSMutableArray*) getObjectsforEntity:(NSString *)strEntity ShortBy:(NSString *)strShort isAscending:(BOOL)ascending;
-(NSMutableArray*) getObjectsforEntity:(NSString *)strEntity ShortBy:(NSString *)strShort isAscending:(BOOL)ascending predicate:(NSPredicate *)predicate;

//-(NSMutableArray*)getFeedEntitiyforMostResent;
//-(NSMutableArray*)getFeedEntitiyforMostVoted;
-(NSMutableArray*)getFeedEntitiyforMostResent:(NSInteger )pageNo;
-(NSMutableArray*)getFeedEntitiyforMostVoted:(NSInteger )pageNo;
-(NSMutableArray*)getFeedEntitiyforSearch:(NSInteger )pageNo;

-(NSMutableArray*)getFeedEntitiyforMyScene:(NSInteger )pageNo;
-(NSMutableArray*)getFeedEntitiyforMyComments:(NSInteger )pageNo;
-(NSMutableArray*)getFeedEntitiyforMostDiscussed:(NSInteger )pageNo;


-(NSUInteger) getObjectCountforEntity:(NSString *)strEntity withPredicate:(NSPredicate *)predicate;


-(void) deleteObjectsForEntity:(NSString *)strEntity;
-(void)deleteObject:(NSManagedObject *)managedObject;

-(NSUInteger) getObjectCountforEntity:(NSString *)strEntity;

-(void) deleteObjectsForEntity:(NSString *)strEntity withPredicate:(NSPredicate *)predicate;

-(NSMutableArray *) getObjectsforEntityForUpdate:(NSString *)strEntity;

-(void)createOrReplaceObjectToCoreData:(NSDictionary *)dict forEntity:(NSString *)strEntityName withvidType:(NSString *)vidType;


+(DBHelper *)sharedDBHelper;


-(NSNumber *)getNumberFromString:(NSString *)string;
-(NSDate *)getDateFromString:(NSString *)strdate;



@end
