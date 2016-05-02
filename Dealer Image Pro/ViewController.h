//
//  ViewController.h
//  Dealer Image Pro
//
//  Created by Sean on 4/15/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadImages.h"

@class DBRestClient;

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tvCars;

    DBRestClient* restClient;
}

@end

