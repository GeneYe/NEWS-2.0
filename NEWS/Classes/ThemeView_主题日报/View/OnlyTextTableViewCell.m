//
//  OnlyTextTableViewCell.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/2.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "OnlyTextTableViewCell.h"

@implementation OnlyTextTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+(instancetype)createOnlyTextTableViewCellWithTableView:(UITableView *)tableView Model:(Themes_Model *)model{
    
    static NSString *identifier = @"createOnlyTextTableViewCell";
    
    OnlyTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OnlyTextTableViewCell" owner:nil options:nil] objectAtIndex:0];
        
        cell.titleLabel.text = model.title;
        
        cell.backgroundColor = [UIColor clearColor];
    }

    return cell;
    
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
