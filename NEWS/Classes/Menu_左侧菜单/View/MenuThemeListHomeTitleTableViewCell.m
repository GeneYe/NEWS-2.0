//
//  MenuThemeListHomeTitleTableViewCell.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/10.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "MenuThemeListHomeTitleTableViewCell.h"

@implementation MenuThemeListHomeTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (instancetype)createMenuThemeListHomeTitleWithTableView:(UITableView *)tableView Model:(ThemeTitle_Model *)model{
    
    static NSString *identifier = @"homeCell";
    
    MenuThemeListHomeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuThemeListHomeTitleTableViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.menuListThemeHomeTitle.text = model.name;
        cell.menuListThemeHomeTitle.textColor = GYFontColor;
        cell.menuListThemeHomeTitle.font = [UIFont systemFontOfSize:16.0];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = GYCellSelectedColor;
        cell.menuListThemeHomeTitle.highlightedTextColor = [UIColor whiteColor];
    }
    return cell;
}

@end
