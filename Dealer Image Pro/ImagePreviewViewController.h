//
//  ImagePreviewViewController.h
//  Dealer Image Pro
//
//  Created by Mitul on 30/04/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePreviewViewController : UIViewController
{
    IBOutlet UIImageView *imgPreview;
}

@property (strong , nonatomic)NSString *strDirPath;

@property (strong  ,nonatomic) UIImage *imgPrv;

@end
