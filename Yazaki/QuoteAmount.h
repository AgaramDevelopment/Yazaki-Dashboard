//
//  QuoteAmount.h
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteAmount : UIViewController
@property (nonatomic,strong) IBOutlet UITableView * QuoteAmount_tbl;
@property (nonatomic,strong) IBOutlet NSString * plantCode;
@property (nonatomic,strong) IBOutlet NSString *  customCode;
@property (nonatomic,strong) IBOutlet NSString * programname;

@property (strong, nonatomic) NSDictionary *serviceResponse;
@end
