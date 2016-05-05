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
#define root1       kDBRootDropbox  //@"dropbox"

#define Hero   @"Hero"
#define Front  @"Front"
#define Hero2  @"Hero 2"
#define Next   @"Next"
#define Done   @"Done"
#define ReverseHero @"Reverse Hero"
#define Rear @"Rear"
#define Cockpit @"Cockpit"
#define Console @"Console"
#define Seats2 @"Seats 2"
#define RearBadge1 @"Rear Badge 1"
#define Wheel @"Wheel"
#define Engine @"Engine"
#define Keys @"Keys"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *relinkUserId;
    
    UIView *loadView;
    UIView *viewBack;
    UILabel *lblLoading;
    UIActivityIndicatorView *spinningWheel;

}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+(AppDelegate *)sharedAppDelegate;

-(void)showLoadingView;
-(void) hideLoadingView;

@end

