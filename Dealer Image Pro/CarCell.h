//
//  CarCell.h
//  Dealer Image Pro
//
//  Created by Mitul on 03/05/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarCellDelegate  <NSObject>

-(void)deleteButtonClickAtIndex:(int)index;

@end

@interface CarCell : UITableViewCell
{
    id<CarCellDelegate> delegate;
}
@property (strong , nonatomic)id<CarCellDelegate> delegate;

@property (nonatomic)int cellIndex;
@property (strong , nonatomic)IBOutlet UILabel *lblTitle;


@end
