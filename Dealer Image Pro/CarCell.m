//
//  CarCell.m
//  Dealer Image Pro
//
//  Created by Mitul on 03/05/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

@synthesize lblTitle;
@synthesize delegate;
@synthesize cellIndex;

- (void)awakeFromNib {
    // Initialization code
}


-(IBAction)onClickDeleteDir:(id)sender
{
    if(delegate && [delegate respondsToSelector:@selector(deleteButtonClickAtIndex:)]){
        [delegate deleteButtonClickAtIndex:cellIndex];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
