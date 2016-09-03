//
//  ProductionVC.h
//  Yazaki
//
//  Created by Lexicon on 29/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductionVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSString *Tittle;


@property(strong,nonatomic)NSString *FromStr;
@property(strong,nonatomic)NSString *ToStr;
@property(strong,nonatomic)NSString *selectPlantCode;
@property (strong, nonatomic) IBOutlet UITableView *tablview;

@end
