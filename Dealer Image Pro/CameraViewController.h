//
//  CameraViewController.h
//  Dealer Image Pro
//
//  Created by Sean Anderson on 4/28/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain) NSString *strImgDir;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *btnTakePhoto;

- (IBAction)takePhoto:  (UIButton *)sender;

@end
