//
//  EfficiencyLineVC.h
//  Yazaki
//
//  Created by Lexicon on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfficiencyLineVC : UIViewController

@property (nonatomic,strong) NSString *Tittle;


@property (strong, nonatomic) IBOutlet UITableView *tablview;


@property (strong, nonatomic)NSString* fromstr;
@property (strong, nonatomic)NSString*tostr;
@property (strong, nonatomic)NSString*selectPlantCode;
@end
