//
//  ViewController.m
//  Dealer Image Pro
//
//  Created by Sean on 4/15/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import "ViewController.h"
#import "ImageCaptureViewController.h"

#import <DropboxSDK/DropboxSDK.h>
#import <stdlib.h>

@interface ViewController () <DBRestClientDelegate>
{
    NSMutableArray *fileList;
    NSString *strSelectedDir;
}

@end

@implementation ViewController

@synthesize objManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    // Do any additional setup after loading the view, typically from a nib.
    
   // [self getAllImagesFromCore];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    // [objManager logoutFromDropbox];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    objManager = [DropboxManager dropBoxManager];
    objManager.apiCallDelegate =self;
    [objManager initDropbox];
    [objManager loginToDropbox];
    
    //[objManager logoutFromDropbox];
    [self getAllDirFromDocs];
}

-(void)getAllDirFromDocs
{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    fileList = (NSMutableArray *) [manager contentsOfDirectoryAtPath:strPath error:nil];
    [tvCars reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadButton:(id)sender {
    
    if([fileList count] > 0){
        NSString *dirName = [fileList objectAtIndex:0];
        [self createFolderInDropboxWithName:dirName];
    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"No folder Available to upload" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarCell *cell = (CarCell *) [tableView dequeueReusableCellWithIdentifier:@"carCell"];
    //if (cell == nil) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"carCell"];
  //  }
    cell.cellIndex =  (int)indexPath.row;
    cell.lblTitle.text = [fileList objectAtIndex:indexPath.row];
    cell.delegate = self;
    
    return cell;
}

-(void)deleteButtonClickAtIndex:(int)index
{
    if([fileList count] > index){
        
        deleteAlert =[[UIAlertView alloc]initWithTitle:@"Are you sure ? you want to delete ?" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        deleteAlert.tag = index;
        [deleteAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == deleteAlert){
        if(buttonIndex == 1){
            if([fileList count] > alertView.tag){
                NSString *dirName = [fileList objectAtIndex:alertView.tag];
                [self removeUploadedDir:dirName];
                
                [self getAllDirFromDocs];
            }
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Row:%d selected and its data is %@",
          indexPath.row,cell.textLabel.text);
    
    strSelectedDir  =[fileList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ImageCaptureViewController1" sender:self];*/
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"ImageCaptureViewController1"]){
        
        ImageCaptureViewController *vcToPushTo = segue.destinationViewController;
        vcToPushTo.strDirPath = strSelectedDir;
    }
}

-(void)createFolderInDropboxWithName:(NSString *)strName
{
    NSString *strfolder = [[strName componentsSeparatedByString:@"/"] lastObject];
    [self uploadImageWithFolderName:strfolder];
}

-(void)uploadImageWithFolderName:(NSString *)strDir
{
    
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    strPath = [strPath stringByAppendingPathComponent:strDir];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arrTotalImages =  [manager contentsOfDirectoryAtPath:strPath error:nil];
    
    if([arrTotalImages count] ==0 ){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No photo Available please capture photo." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [[AppDelegate sharedAppDelegate]showLoadingView];
    uploadArray =[[NSMutableArray alloc]init];
    for (int i=0 ; i< [arrTotalImages count]; i++) {
        
        NSString *strfileName = [arrTotalImages objectAtIndex:i];
        NSString *destifilePath = [NSString stringWithFormat:@"/%@/%@" ,strDir ,strfileName];
        
        NSString *sourcePath = [NSString stringWithFormat:@"%@/%@", strPath , strfileName];
        
        
        NSLog(@"DESTINATION FILE %@", destifilePath);
        NSLog(@"SOURCE FILE %@", sourcePath);
        
        [uploadArray addObject:destifilePath];
        
        objManager.strFileName = strfileName;
        objManager.strDestDirectory = [NSString stringWithFormat:@"/%@" ,strDir];
        objManager.strFilePath = sourcePath;
        [objManager uploadFile];
        
    }
}


#pragma mark -
#pragma mark - DROPBOX MANAGER DELEGATES

- (void)finishedLogin:(NSMutableDictionary*)userInfo
{
    NSLog(@"FINISH LOGIN %@",userInfo);
}
- (void)failedToLogin:(NSString*)withMessage
{
    NSLog(@"FAIL LOGIN %@", withMessage);
}

- (void)finishedCreateFolder:(NSString *)folderName
{
    NSLog(@"CREATE FOLDER SUCCESSFULLY %@",folderName);
    
}


- (void)failedToCreateFolder:(NSString*)withMessage
{
    NSLog(@"FAILT TO CREATE FOLDER %@", withMessage);
}

- (void)finishedUploadFile:(NSString *)uploadFile
{
    NSLog(@"UPLOAD FILE  %@", uploadFile);
    
    if([uploadArray count] > 0){
        [uploadArray removeObject:uploadFile];
    }
    
    if([uploadArray count] ==0){
        
        [[AppDelegate sharedAppDelegate]hideLoadingView];
        [self removeUploadedDir:uploadFile];
        
        [self performSelector:@selector(uploadAgain) withObject:nil afterDelay:0.5f];
    }
}

-(void)uploadAgain
{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    fileList = (NSMutableArray *) [manager contentsOfDirectoryAtPath:strPath error:nil];
    [tvCars reloadData];
    
    if([fileList count] == 0){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"All Photos Uploaded successfully." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        NSString *dirName = [fileList objectAtIndex:0];
        [self createFolderInDropboxWithName:dirName];
    }

}

- (void)failedToUploadFile:(NSString*)withMessage
{
    NSLog(@"FAILT TO UPLOAD FILE %@", withMessage);
    [[AppDelegate sharedAppDelegate]hideLoadingView];
}



-(void)removeUploadedDir:(NSString *)dirPath
{
    
    NSString *dirName = [[[dirPath substringFromIndex:1] componentsSeparatedByString:@"/"] firstObject];
    if(dirName != nil){
        NSString *path;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [[paths objectAtIndex:0] stringByAppendingPathComponent:dirName];
        NSLog(@"DELETE PATH  >>>>>>>>>  %@", path);
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Fail To delete Directory." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


-(void)getAllImagesFromCore
{
   NSMutableArray *arrData = [[DBHelper sharedDBHelper] getObjectsforEntity:ENTITY_IMAGES];
    
    fileList =[[NSMutableArray alloc]init];
    if(arrData.count > 0){
        [fileList addObjectsFromArray:arrData];
    }
    [tvCars reloadData];
}







@end
