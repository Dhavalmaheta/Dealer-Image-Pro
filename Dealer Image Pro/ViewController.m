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

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    // Do any additional setup after loading the view, typically from a nib.
    
   // [self getAllImagesFromCore];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self createFolderInDropboxWithName:@"TESTING CHECK"];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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
    
    UIAlertView *uploadAlertView = [[UIAlertView alloc] initWithTitle:@"Upload to Dealer Image Pro" message:nil delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Upload", nil];
    [uploadAlertView show];
    
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"carCell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [fileList objectAtIndex:indexPath.row];
    
    /*
    UploadImages *imgData = [fileList objectAtIndex:indexPath.row];
    cell.textLabel.text = imgData.folderName;
    */
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Row:%d selected and its data is %@",
          indexPath.row,cell.textLabel.text);
     */
    
    strSelectedDir  =[fileList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ImageCaptureViewController1" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"ImageCaptureViewController1"]){
        
        ImageCaptureViewController *vcToPushTo = segue.destinationViewController;
        vcToPushTo.strDirPath = strSelectedDir;
    }
}

-(void)createFolderInDropboxWithName:(NSString *)strName
{
    [[self restClient] createFolder:strName];
}

-(void)uploadImageWithFolderName:(NSString *)strDir
{
    
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    strPath = [strPath stringByAppendingPathComponent:strDir];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arrTotalImages =  [manager contentsOfDirectoryAtPath:strPath error:nil];
    
    [[self restClient] createFolder:strDir];
    
    for (int i=0 ; i< [arrTotalImages count]; i++) {
        
        NSString *strfileName = [arrTotalImages objectAtIndex:i];
        NSString *destifilePath = [NSString stringWithFormat:@"%@/%@" ,strDir ,strfileName];
        
        NSString *sourcePath = [NSString stringWithFormat:@"%@/%@", strPath , strfileName];

        NSLog(@"DESTINATION FILE %@", destifilePath);
        NSLog(@"SOURCE FILE %@", sourcePath);
        
        [[self restClient] uploadFile:strfileName toPath:destifilePath withParentRev:nil fromPath:sourcePath];
    }
}


#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    
   // [photosHash release];
   // photosHash = [metadata.hash retain];
    
    /*
    NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
    NSMutableArray* newPhotoPaths = [NSMutableArray new];
    for (DBMetadata* child in metadata.contents) {
        NSString* extension = [[child.path pathExtension] lowercaseString];
        if (!child.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
            [newPhotoPaths addObject:child.path];
        }
    }
     */
    
   // [photoPaths release];
   // photoPaths = newPhotoPaths;
   // [self loadRandomPhoto];
}

- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
   // [self loadRandomPhoto];
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
   // [self displayError];
   // [self setWorking:NO];
}

- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath {
   // [self setWorking:NO];
   // imageView.image = [UIImage imageWithContentsOfFile:destPath];
}

- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
   // [self setWorking:NO];
   // [self displayError];
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

- (DBRestClient*)restClient {
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}






@end
