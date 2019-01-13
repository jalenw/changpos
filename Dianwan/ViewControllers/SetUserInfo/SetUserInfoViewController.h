//
//  SetUserInfoViewController.h
//  Dianwan
//
//  Created by Yang on 2019/1/10.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetUserInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *idCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UITextField *addreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAcover;

@end

NS_ASSUME_NONNULL_END
