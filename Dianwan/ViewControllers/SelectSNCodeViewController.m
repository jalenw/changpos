//
//  SelectSNCodeViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/11.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "SelectSNCodeViewController.h"
#import "SNCodeSelectTableViewCell.h"
@interface SelectSNCodeViewController ()

@end

@implementation SelectSNCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择SN号";
    [self setRightBarButtonWithTitle:@"确定"];
}

-(void)rightbarButtonDidTap:(UIButton *)button
{
    NSMutableString *mutStr = [[NSMutableString alloc]init];
    for (NSString *str in self.data) {
        [mutStr appendString:str];
        [mutStr appendString:@","];
    }
    if (self.data.count>0&&[mutStr containsString:@","]) {
        [mutStr replaceCharactersInRange:NSMakeRange(mutStr.length-1, 1) withString:@""];
    }
    self.block(mutStr);
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"SNCodeSelectTableViewCell";
    SNCodeSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.array.count>0) {
        NSDictionary *dict = [self.array objectAtIndex:indexPath.row];
        cell.name.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"sn_code"]];
        cell.img.hidden = YES;
        for (NSString *str in self.data) {
            if ([str isEqualToString:cell.name.text]) {
                cell.img.hidden = NO;
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = [self.array objectAtIndex:indexPath.row];
    if ([self.data containsObject:[dict safeStringForKey:@"sn_code"]]) {
        [self.data removeObject:[dict safeStringForKey:@"sn_code"]];
    }
    else
    {
        [self.data addObject:[dict safeStringForKey:@"sn_code"]];
    }
    [self.tableView reloadData];
}

@end
