//
//  ScrapDetailVC.h
//  Yazaki
//
//  Created by APPLE on 29/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrapDetailVC : UIViewController
@property (nonatomic,strong) NSString * fromDate;
@property (nonatomic,strong) NSString * Todate;
@property (nonatomic,strong) NSString * selectplancode;
@property (nonatomic,strong) NSString * STATUS;
@property (nonatomic,strong) NSString * SelectareaCode;
@property (strong, nonatomic) NSDictionary *serviceResponse;

@end
