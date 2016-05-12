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
    
    NSString *vehicleManager = @"";
    
    // Establish setting for vehicle manager
    if ((_vehicleType.selectedSegmentIndex==0) && (_vehicleReady.selectedSegmentIndex==0)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"New Vehicle that is ready");}
    
    else if ((_vehicleType.selectedSegmentIndex==1) && (_vehicleReady.selectedSegmentIndex==0)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"Used Vehicle that is ready");}
    else if ((_vehicleType.selectedSegmentIndex==1) && (_vehicleReady.selectedSegmentIndex==1)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"Used Vehicle that is not ready");}
    else if ((_vehicleType.selectedSegmentIndex==0) && (_vehicleReady.selectedSegmentIndex==1)){
        _bodyStyle.hidden = true;
        _disabledBodyStyle.hidden = false;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
        NSLog(@"New Vehicle that is not ready");}
}
- (IBAction)vehicleReady:(id)sender {
    if ((_vehicleType.selectedSegmentIndex==0) && (_vehicleReady.selectedSegmentIndex==0)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"New Vehicle that is ready");}
    
    else if ((_vehicleType.selectedSegmentIndex==1) && (_vehicleReady.selectedSegmentIndex==0)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"Used Vehicle that is ready");}
    else if ((_vehicleType.selectedSegmentIndex==1) && (_vehicleReady.selectedSegmentIndex==1)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"Used Vehicle that is not ready");}
    else if ((_vehicleType.selectedSegmentIndex==0) && (_vehicleReady.selectedSegmentIndex==1)){
        _bodyStyle.hidden = true;
        _disabledBodyStyle.hidden = false;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
        NSLog(@"New Vehicle that is not ready");}
    
}
- (IBAction)vehicleTypeButton:(id)sender {
    if ((_vehicleType.selectedSegmentIndex==0) && (_vehicleReady.selectedSegmentIndex==0)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"New Vehicle that is ready");}
    
    else if ((_vehicleType.selectedSegmentIndex==1) && (_vehicleReady.selectedSegmentIndex==0)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"Used Vehicle that is ready");}
    else if ((_vehicleType.selectedSegmentIndex==1) && (_vehicleReady.selectedSegmentIndex==1)){
        _bodyStyle.hidden = false;
        _disabledBodyStyle.hidden = true;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        NSLog(@"Used Vehicle that is not ready");}
    else if ((_vehicleType.selectedSegmentIndex==0) && (_vehicleReady.selectedSegmentIndex==1)){
        _bodyStyle.hidden = true;
        _disabledBodyStyle.hidden = false;
        _bodyStyleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
        NSLog(@"New Vehicle that is not ready");}
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
    
    if ([_stockNumer.text isEqualToString:_confirmVin.text]){
        
    
    
    
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
    
    if (_vehicleType.selectedSegmentIndex==0){
        
        strMainPath = [self genDirectory];
        [self createDirForImage:strMainPath];
        
        ImageCaptureViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageCaptureViewController"];
        newView.strDirPath = strMainPath;
        newView.strStockNumber = _stockNumer.text;
        [self.navigationController pushViewController:newView animated:YES];
    }
    
    if (_vehicleType.selectedSegmentIndex==1){
        
        strMainPath = [self genDirectory];
        [self createDirForImage:strMainPath];
        
        ImageCaptureViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageCaptureViewController2"];
        newView.strDirPath = strMainPath;
        newView.strStockNumber = _stockNumer.text;
        [self.navigationController pushViewController:newView animated:YES];
    }
    

    }else {
        _vinNumberLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        _confirmVinLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        
    }

//    strMainPath = [self genDirectory];
//    [self createDirForImage:strMainPath];
//    
//    ImageCaptureViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageCaptureViewController2"];
//    newView.strDirPath = strMainPath;
//    newView.strStockNumber = _stockNumer.text;
//    [self.navigationController pushViewController:newView animated:YES];
    
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

- (IBAction)vinValueChange:(id)sender {
    
    _vinNumberLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    _confirmVinLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    
}

- (IBAction)confirmValueChange:(id)sender {
    _vinNumberLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    _confirmVinLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
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

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


@end
