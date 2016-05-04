//
//  ImageCaptureViewController.h
//  Dealer Image Pro
//
//  Created by Mitul on 30/04/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SCTouchDetector.h"
#import "SCRecordSessionManager.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "SCRecorder.h"


@interface ImageCaptureViewController : UIViewController<SCRecorderDelegate, UIImagePickerControllerDelegate>
{
    SCRecorder *_recorder;
    UIImage *_photo;
    SCRecordSession *_recordSession;
    UIImageView *_ghostImageView;
    
    IBOutlet UILabel *lblTitle;
    IBOutlet UIImageView *imgFocusView;
    
    IBOutlet UIButton *btnCapture;
}
@property (strong, nonatomic) SCRecorderToolsView *focusView;
@property (weak, nonatomic) IBOutlet UIView *previewView;


@property (strong , nonatomic)NSString *strDirPath;
@property (strong , nonatomic)NSString *strStockNumber;

@end
