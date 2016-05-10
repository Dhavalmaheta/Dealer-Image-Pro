//
//  ViewController.h
//  Dealer Image Pro
//
//  Created by Sean on 4/15/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadImages.h"
#import "CarCell.h"
#import "DropboxManager.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource , DropBoxDelegate , CarCellDelegate , UIAlertViewDelegate>
{
    
    __weak IBOutlet UIVisualEffectView *uploadImageBlur;
    IBOutlet UITableView *tvCars;
    DBRestClient* restClient;
    
    DropboxManager *objManager;
    
    NSMutableArray *uploadArray;
    
    UIAlertView *deleteAlert;
}
@property (nonatomic,strong) DropboxManager *objManager;
@property (weak, nonatomic) IBOutlet UIButton *uploadIcon;


@end

