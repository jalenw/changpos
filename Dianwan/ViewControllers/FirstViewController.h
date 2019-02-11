//
//  FirstViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2018/8/1.
//  Copyright © 2018年 intexh. All rights reserved.
//

#import "BaseViewController.h"
#import "AdView.h"
@interface FirstViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet AdView *adView;
@property (weak, nonatomic) IBOutlet UILabel *rankTurnover;
@property (weak, nonatomic) IBOutlet UILabel *rankActivity;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *profitView;
@property (weak, nonatomic) IBOutlet UIView *rankView;
- (IBAction)moreAct:(UIButton *)sender;
- (IBAction)menuAct:(UIButton *)sender;
@end
