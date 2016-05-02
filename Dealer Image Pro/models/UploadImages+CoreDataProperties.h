//
//  UploadImages+CoreDataProperties.h
//  Dealer Image Pro
//
//  Created by Mitul on 29/04/16.
//  Copyright © 2016 gooey apps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UploadImages.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadImages (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *filePath;
@property (nullable, nonatomic, retain) NSString *folderName;
@property (nullable, nonatomic, retain) NSString *make;
@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *stoke;

@end

NS_ASSUME_NONNULL_END
