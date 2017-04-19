//
//  EditorsTableViewCell.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/13.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorsTableViewCell : UITableViewCell

+ (instancetype)createEditorsTableViewCellWithTableView:(UITableView *)tableView EditorsArray:(NSMutableArray *)array;

@end
