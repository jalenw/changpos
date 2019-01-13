//
//  UserFeedBackViewController.h
//  0756yc
//
//  Created by LinShaoWei on 15/11/14.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface UserFeedBackViewController : BaseViewController<UITextViewDelegate>{
    BOOL isEditText;
    UITextView *textview;
}

@end
