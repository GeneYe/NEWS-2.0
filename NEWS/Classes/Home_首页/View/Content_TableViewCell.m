//
//  Content_TableViewCell.m
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "Content_TableViewCell.h"


@implementation Content_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

+ (instancetype)createTitleAndImageCellWithTableView:(UITableView *)tableView Model:(Content_Model *)model{
    
    static NSString *identifier = @"imageAndTitleCell";
    
    Content_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Content_TableViewCell" owner:nil options:nil] objectAtIndex:0];
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.title_Label.text = model.title;
        
        [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(changeColor:) name:@"color" object:nil];
        
        NSString *urlStr = model.images[0];
        
        [cell.title_image sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    }
    return cell;

    
}

- (void)changeColor:(NSNotification *)notification{
    
    _cellBackgroundColor = notification.userInfo[@"color"];
    
    [_title_Label setTextColor:_cellBackgroundColor];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
