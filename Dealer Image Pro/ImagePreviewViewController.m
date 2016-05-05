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
@synthesize strNumberStock;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.imgPrv != nil){
        
        imgPreview.image = self.imgPrv;
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setImageCount:strDirPath];
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
                                              cancelButtonTitle:@"Ok"
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
    if([arrTotalImages count] > 8){
        strImageName =[NSString stringWithFormat:@"%@--%d",strNumberStock,arrTotalImages.count +1] ;
    }else{
        strImageName =[NSString stringWithFormat:@"%@--0%d",strNumberStock,arrTotalImages.count + 1] ;
    }
    
    return strImageName;
}
-(void)setImageCount:(NSString *)dir
{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    strPath = [strPath stringByAppendingPathComponent:dir];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arrTotalImages =  [manager contentsOfDirectoryAtPath:strPath error:nil];
    
    if (arrTotalImages.count == 0) {
        lblDone.text = Next;
    }else if (arrTotalImages.count == 1){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 2){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 3){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 4){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 5){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 6){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 7){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 8){
        lblDone.text = Next;
    }else if (arrTotalImages.count == 9){
        lblDone.text = Next;
    }else if (arrTotalImages.count >= 10){
    lblDone.text = Done;
}
}






@end
