//
//  ImageCaptureViewController.m
//  Dealer Image Pro
//
//  Created by Mitul on 30/04/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import "ImageCaptureViewController.h"
#import "ImagePreviewViewController.h"

@interface ImageCaptureViewController ()

@end


@implementation ImageCaptureViewController

@synthesize strDirPath;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _recorder = [SCRecorder recorder];
    _recorder.captureSessionPreset = [SCRecorderTools bestCaptureSessionPresetCompatibleWithAllDevices];
    _recorder.delegate = self;
    _recorder.autoSetVideoOrientation = YES;
    _recorder.captureSessionPreset = AVCaptureSessionPresetHigh;
    _recorder.flashMode = SCFlashModeOff;
    
    UIView *previewView = self.previewView;
    _recorder.previewView = previewView;
    
    _recorder.initializeSessionLazily = NO;
    
    NSError *error;
    if (![_recorder prepare:&error]) {
        NSLog(@"Prepare error: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didSkipVideoSampleBufferInSession:(SCRecordSession *)recordSession {
    NSLog(@"Skipped video buffer");
}

- (void)recorder:(SCRecorder *)recorder didReconfigureAudioInput:(NSError *)audioInputError {
    NSLog(@"Reconfigured audio input: %@", audioInputError);
}

- (void)recorder:(SCRecorder *)recorder didReconfigureVideoInput:(NSError *)videoInputError {
    NSLog(@"Reconfigured video input: %@", videoInputError);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareSession];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_recorder previewViewFrameChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_recorder startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_recorder stopRunning];
}


-(IBAction)onClickBackToMain:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)capturePhoto:(id)sender {
    [_recorder capturePhoto:^(NSError *error, UIImage *image) {
        if (image != nil) {
            
            ImagePreviewViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ImagePreviewViewController"];
            newView.strDirPath = strDirPath;
            newView.imgPrv = image;
            [self.navigationController presentViewController:newView animated:YES completion:nil];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to capture photo"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

/*
-(void)pushtoMainView:(UIImage *)img
{
    // save Image To Directory
    if(strDirPath != nil){
        
        NSString *path;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [[paths objectAtIndex:0] stringByAppendingPathComponent:strDirPath];
       // NSError *error;
        
        NSLog(@"FILE DICT %@", path);
        
        NSString *strFilename = [[strDirPath componentsSeparatedByString:@"/"] lastObject];
        NSString *strPath =[NSString stringWithFormat:@"%@/%@.jpg",path , [self getImageName:strFilename]];
        
        [UIImageJPEGRepresentation(img,1.0) writeToFile:strPath atomically:YES];
        
        //[self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to save photo"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
} */



-(IBAction)onclickCameraMode:(id)sender
{
    [_recorder switchCaptureDevices];
}

- (void)prepareSession {
    if (_recorder.session == nil) {
        
        SCRecordSession *session = [SCRecordSession recordSession];
        session.fileType = AVFileTypeQuickTimeMovie;
        
        _recorder.session = session;
    }
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



- (void)recorder:(SCRecorder *)recorder didCompleteSession:(SCRecordSession *)recordSession {
    NSLog(@"didCompleteSession:");
    //[self saveAndShowSession:recordSession];
}

- (void)recorder:(SCRecorder *)recorder didInitializeAudioInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Initialized audio in record session");
    } else {
        NSLog(@"Failed to initialize audio in record session: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didInitializeVideoInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Initialized video in record session");
    } else {
        NSLog(@"Failed to initialize video in record session: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didBeginSegmentInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    NSLog(@"Began record segment: %@", error);
}

- (void)recorder:(SCRecorder *)recorder didCompleteSegment:(SCRecordSessionSegment *)segment inSession:(SCRecordSession *)recordSession error:(NSError *)error {
    NSLog(@"Completed record segment at %@: %@ (frameRate: %f)", segment.url, error, segment.frameRate);
    //[self updateGhostImage];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
