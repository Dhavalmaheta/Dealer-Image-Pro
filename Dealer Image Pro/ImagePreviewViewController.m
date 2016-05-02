//
//  ImagePreviewViewController.m
//  Dealer Image Pro
//
//  Created by Mitul on 30/04/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import "ImagePreviewViewController.h"

@interface ImagePreviewViewController ()

@end

@implementation ImagePreviewViewController

@synthesize strDirPath;
@synthesize imgPrv;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.imgPrv != nil){
        
        /*NSString *path;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [[paths objectAtIndex:0] stringByAppendingPathComponent:strDirPath];
        NSError *error;
        
        NSLog(@"FILE DICT %@", path);
        
        NSString *strFilename = [[strDirPath componentsSeparatedByString:@"/"] lastObject];
        NSString *strPath =[NSString stringWithFormat:@"%@/%@.jpg",path , strFilename];
         */
        imgPreview.image = self.imgPrv;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(IBAction)onClickReShoot:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)onClickNext:(id)sender
{
    
    if(strDirPath != nil){
        
        NSString *path;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [[paths objectAtIndex:0] stringByAppendingPathComponent:strDirPath];
        // NSError *error;
        
        NSLog(@"FILE DICT %@", path);
        
        NSString *strFilename = [[strDirPath componentsSeparatedByString:@"/"] lastObject];
        NSString *strPath =[NSString stringWithFormat:@"%@/%@.jpg",path , [self getImageName:strFilename]];
        
        [UIImageJPEGRepresentation(imgPreview.image,1.0) writeToFile:strPath atomically:YES];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to save photo"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)getImageName:(NSString *)dir
{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    strPath = [strPath stringByAppendingPathComponent:dir];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arrTotalImages =  [manager contentsOfDirectoryAtPath:strPath error:nil];
    
    NSLog(@"ALL IMAGES %@", arrTotalImages);
    
    NSString *strImageName;
    if([arrTotalImages count] > 9){
        strImageName =[NSString stringWithFormat:@"Stock#_%d",arrTotalImages.count +1] ;
    }else{
        strImageName =[NSString stringWithFormat:@"Stock#_0%d",arrTotalImages.count + 1] ;
    }
    
    return strImageName;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
