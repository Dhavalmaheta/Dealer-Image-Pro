//
//  MainController.m
//  Dealer Image Pro
//
//  Created by Sean on 4/16/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import "MainController.h"
#import "ImageCaptureViewController.h"

@interface MainController (){
    NSString *strMainPath;
}

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)onClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    if(![_stockNumer hasText]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Stock Number is required"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![_vehicleMake hasText]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vehicle Make is required"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![_vehicleModel hasText]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vehicle Model is required"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    strMainPath = [self genDirectory];
    [self createDirForImage:strMainPath];
    
    ImageCaptureViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageCaptureViewController"];
    newView.strDirPath =strMainPath;
    [self.navigationController pushViewController:newView animated:YES];

}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"ImageCaptureViewController"]){
        //ImageCaptureViewController *mVC = [segue destinationViewController];
        //mVC.strDirPath = strMainPath;
        //[self performSegueWithIdentifier:@"ImageCaptureViewController" sender:self];
    }
} */





-(NSString *)genDirectory{
    
    //NSString *strPath = [NSHomeDirectory() stringByAppendingPathComponent:@"projectwax"];
    NSString *strDir = [NSString stringWithFormat:@"/(%@_%@)%@", _vehicleMake.text, _vehicleModel.text, _stockNumer.text];//(Ford_GT)A5112785
    //strPath = [strPath stringByAppendingString:strDir];
    
    return strDir;
}


-(void)createDirForImage :(NSString *)dirName
{
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:dirName];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])    //Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&error])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Directory Error"
                                                            message:error.description
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return ;
        }
        else{
            
        }
    }
    return;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}


@end
