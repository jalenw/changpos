//
//  MerchantTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MerchantTableViewCell.h"
#import "JXCircleRatioView.h"
#import "JXCircleModel.h"
@interface MerchantTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *snNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *countNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet JXCircleRatioView *circleRatioView;

//@property(nonatomic,strong)JXCircleRatioView *circleRatioView;
@end

@implementation MerchantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    //开始绑定数据到UI
    self.timeLabel.text = [[_dict safeStringForKey:@"actication_time"] substringToIndex:[_dict safeStringForKey:@"actication_time"].length -8 ];
    self.nameLabel.text = [_dict safeStringForKey:@"goods_name"];
    self.snNumLabel.text =[NSString stringWithFormat:@"%@",[_dict safeStringForKey:@"sn_code"]];
    self.name.text = [_dict safeStringForKey:@"merchant_name"];
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计 ¥%@",[_dict safeStringForKey:@"lg_av_amount"]]];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSRange range = [[NSString stringWithFormat:@"累计:%@",[_dict safeStringForKey:@"total_price"]] rangeOfString:@":"];
    NSRange pointRange = NSMakeRange(0, range.location+1);
    [attribut addAttribute:NSForegroundColorAttributeName
                     value:[UIColor whiteColor]
                     range:pointRange];
    
    self.countNumLabel.attributedText =attribut;
    JXCircleModel *model1 = [[JXCircleModel alloc]init];
    model1.number = [_dict safeStringForKey:@"lg_av_amount"];
    model1.color = [UIColor greenColor];
    
    
    JXCircleModel *model2 = [[JXCircleModel alloc]init];
    model2.number =[NSString stringWithFormat:@"%f",[[_dict safeStringForKey:@"target_price"] floatValue]] ;
    model2.color = [UIColor redColor];
    [self.circleRatioView updateDataArray:@[model1,model2]];
     self.countLabel.text = [NSString stringWithFormat:@"%0.4f%%",[model1.number floatValue]/[model2.number floatValue]];
    
    
    
}
@end
