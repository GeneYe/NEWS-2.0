//
//  EditorsTableViewCell.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/13.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "EditorsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Editors_model.h"

@implementation EditorsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(instancetype)createEditorsTableViewCellWithTableView:(UITableView *)tableView EditorsArray:(NSMutableArray *)array{
    
    static NSString *identifier = @"editorsCellIdentifier";
    
    EditorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditorsTableViewCell" owner:nil options:nil] objectAtIndex:0];
        
        cell.backgroundColor = [UIColor clearColor];
        
        CGFloat labelWidth = 35 + 15 + 10;
        for (int i = 0; i < array.count; i++) {
            UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(labelWidth + (26 + 15) * i, (40 - 26)/2, 26, 26)];
            
            avatarImageView.layer.cornerRadius = 13;
            
            avatarImageView.layer.masksToBounds = YES;
            
            Editors_model *model = [[Editors_model alloc] initWithDictionary:array[i]];
            
            
            NSString *imageUrl = model.avatar;
            [avatarImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            [cell addSubview:avatarImageView];
            
        }
    }
    return cell;
}

@end
