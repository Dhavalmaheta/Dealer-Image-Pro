//
//  MainController.h
//  Dealer Image Pro
//
//  Created by Sean on 4/16/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *stockNumer;
@property (weak, nonatomic) IBOutlet UITextField *vehicleMake;
@property (weak, nonatomic) IBOutlet UITextField *vehicleModel;
- (IBAction)nextButton:(id)sender;

@end
