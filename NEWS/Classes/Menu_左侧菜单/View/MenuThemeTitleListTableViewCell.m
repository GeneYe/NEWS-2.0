//
//  MenuThemeTitleListTableViewCell.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/10.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "MenuThemeTitleListTableViewCell.h"

@implementation MenuThemeTitleListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}



+ (instancetype)createMeunThemeListExceptHomeWithTableView:(UITableView *)tableView Model:(ThemeTitle_Model *)model{
    
    static NSString *identifier = @"MeunThemeList";
    
    MenuThemeTitleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuThemeTitleListTableViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.MenuThemeListTitle.text = model.name;
        cell.MenuThemeListTitle.font = [UIFont systemFontOfSize:16.0];
        [cell.MenuThemeListTitle setTextColor:GYFontColor];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = GYCellSelectedColor;
        cell.MenuThemeListTitle.highlightedTextColor = [UIColor whiteColor];
        
    }
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
