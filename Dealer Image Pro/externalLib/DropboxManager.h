//
//  DropboxManager.h
//  Dealer Image Pro
//
//  Created by Mitul on 02/05/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <DropboxSDK/DropboxSDK.h>

//#define kDropbox_AppKey @"" // Provide your key here
//#define kDropbox_AppSecret @"" // Provide your secret key here
//#define kDropbox_RootFolder kDBRootDropbox //Decide level access like root or app

@protocol DropBoxDelegate;

typedef enum
{
    DropBoxTypeStatusNone = 0,
    DropBoxGetAccountInfo = 1,
    DropBoxGetFolderList = 2,
    DropBoxCreateFolder = 3,
    DropBoxUploadFile = 4
} DropBoxPostType;


@interface DropboxManager : NSObject <DBRestClientDelegate,DBSessionDelegate,UIAlertViewDelegate>
{
    UIViewController<DropBoxDelegate> *apiCallDelegate;
    
    DBSession *objDBSession;
    NSString *relinkUserId;
    DBRestClient *objRestClient;
    
    DropBoxPostType currentPostType;
    
    NSString *strFileName;
    NSString *strFilePath;
    NSString *strDestDirectory;
    NSString *strFolderCreate;
    NSString *strFolderToList;
}

@property (nonatomic,strong) DBSession *objDBSession;
@property (nonatomic,strong) NSString *relinkUserId;

@property (nonatomic,strong) UIViewController<DropBoxDelegate> *apiCallDelegate;

@property (nonatomic,strong) DBRestClient *objRestClient;

@property (nonatomic,assign) DropBoxPostType currentPostType;

@property (nonatomic,strong) NSString *strFileName;
@property (nonatomic,strong) NSString *strFilePath;
@property (nonatomic,strong) NSString *strDestDirectory;

@property (nonatomic,strong) NSString *strFolderCreate;

@property (nonatomic,strong) NSString *strFolderToList;

//Singleton
+(id)dropBoxManager;

//Initialize dropbox
-(void)initDropbox;

//Authentication Verification
-(BOOL)handledURL:(NSURL*)url;
-(void)dropboxDidLogin;
-(void)dropboxDidNotLogin;

//Upload file
-(void)uploadFile;

//Download File
-(void)downlaodFileFromSourcePath:(NSString*)pstrSourcePath destinationPath:(NSString*)toPath;

//Create Folder
-(void)createFolder;

//Get Account Information
-(void)loginToDropbox;
-(void)logoutFromDropbox;
-(BOOL)isLoggedIn;

//List Folders
-(void)listFolders;

@end

@protocol DropBoxDelegate <NSObject>

@optional

- (void)finishedLogin:(NSMutableDictionary*)userInfo;
- (void)failedToLogin:(NSString*)withMessage;

- (void)finishedCreateFolder:(NSString *)folderName;
- (void)failedToCreateFolder:(NSString*)withMessage;

- (void)finishedUploadFile:(NSString *)uploadFile;
- (void)failedToUploadFile:(NSString*)withMessage;

- (void)finishedDownloadFile;
- (void)failedToDownloadFile:(NSString*)withMessage;

- (void)getFolderContentFinished:(DBMetadata*)metadata;
- (void)getFolderContentFailed:(NSString*)withMessage;

@end
