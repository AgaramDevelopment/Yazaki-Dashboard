//
//  TrainningDetailsVC.h
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainningDetailsVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSString *VersionStatus;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
