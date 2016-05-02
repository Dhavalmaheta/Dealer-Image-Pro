//
//  AppDelegate.h
//  Dealer Image Pro
//
//  Created by Sean on 4/15/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <DropboxSDK/DropboxSDK.h>

#define appKey1     @"pn32am9d3mmhchx"
#define appSecret1  @"nrkpsqeqbrr6fya"
#define root1       @"dropbox"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *relinkUserId;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+(AppDelegate *)sharedAppDelegate;


@end

