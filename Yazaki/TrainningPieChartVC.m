//
//  TrainningPieChartVC.m
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "TrainningPieChartVC.h"
#import "CustomNavigationVC.h"
#import "Common.h"
#import "DashboardVC.h"
#import "TrainningDetailsVC.h"
#import "Theme.h"



@interface TrainningPieChartVC ()
{
    CustomNavigationVC *objCustomNavigation;
    Theme * theme;
    
}
@property (strong, nonatomic) NSMutableArray *values;
@property (strong, nonatomic) NSMutableArray *testARYY;
@property (strong, nonatomic) NSMutableArray *labels;
@property (strong, nonatomic) NSMutableArray *colors;
@property (nonatomic) BOOL inserting;
@property (strong, nonatomic) NSArray *colors1;
@property (strong, nonatomic) NSDictionary *serviceResponse;
@property(strong,nonatomic) NSString *item;
@property(strong,nonatomic)  NSArray *temp;
@property (strong, nonatomic) NSDictionary *sample;

@end

@implementation TrainningPieChartVC

- (void)viewDidLoad {
    [self customnavigationmethod];
    
    theme =[[Theme alloc]init];
    [theme loadingIcon:self.view];
    NSString *baseURL = [NSString stringWithFormat:@"%@/TRAINING/TRAININGDASHBOARDPIE",BaseURL];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if( [_serviceResponse objectForKey:@"CountValues"] == nil ||
           [[_serviceResponse objectForKey:@"CountValues"] isEqual:[NSNull null]] ){
            // value is unavailable
            UILabel *lbl1 = [[UILabel alloc] init];
            [lbl1 setFrame:CGRectMake(100,200,150,150)];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.textColor=[UIColor blackColor];
            lbl1.userInteractionEnabled=YES;
            lbl1.textAlignment=NSTextAlignmentCenter;
            [self.view addSubview:lbl1];
            lbl1.text= @"NO DATA FOUND";
            lbl1.backgroundColor=[UIColor colorWithRed:255/255.0 green:239/255.0 blue:187/255.0 alpha:1.0];
            [lbl1 setFont:[UIFont fontWithName:@"RAJDHANI-BOLD" size:17]];
            
            [lbl1 setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            [lbl1 addConstraint:[NSLayoutConstraint constraintWithItem:lbl1
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute: NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:280]];
            
            // Height constraint
            [lbl1 addConstraint:[NSLayoutConstraint constraintWithItem:lbl1
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute: NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:50]];
            
            // CenterX constraint
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:lbl1
                                                                  attribute: NSLayoutAttributeCenterX
                                                                 multiplier:1
                                                                   constant:0]];
            // Top constraint
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbl1
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.topLayoutGuide
                                                                  attribute: NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:250]];
            
            CALayer * l1 = [lbl1 layer];
            [l1 setMasksToBounds:YES];
            [l1 setCornerRadius:8.0];
            
            // You can even add a border
            [l1 setBorderWidth:5.0];
            [l1 setBorderColor:[[UIColor colorWithRed:229/255.0 green:195/255.0 blue:101/255.0 alpha:1.0] CGColor]];
            self.legend_pie.hidden=YES;
        }else
        {
            NSArray *temp =   [_serviceResponse objectForKey:@"CountValues"];
            if ([temp isKindOfClass:[NSArray class]] && temp.count !=0)
            {
                // value is available
                [self.values removeAllObjects];
                self.values = [NSMutableArray new];
                int i;
                for (i=0; i<[temp count]; i++) {
                    NSDictionary*test=[temp objectAtIndex:i];
                    NSString*add=[test objectForKey:@"CountValue"];
                    [self.values addObject:add];
                    NSString *hellostring=@"0";
                    if( [[test objectForKey:@"CountValue"] isEqual:hellostring]) {
                        //NSString *hellostring=@"NOT ASSIGNED";
                        
                        UILabel *lbl1 = [[UILabel alloc] init];
                        [lbl1 setFrame:CGRectMake(100,200,150,150)];
                        lbl1.backgroundColor=[UIColor clearColor];
                        lbl1.textColor=[UIColor blackColor];
                        lbl1.userInteractionEnabled=YES;
                        lbl1.textAlignment=NSTextAlignmentCenter;
                        [self.view addSubview:lbl1];
                        lbl1.text= @"NO DATA FOUND";
                        lbl1.backgroundColor=[UIColor colorWithRed:255/255.0 green:239/255.0 blue:187/255.0 alpha:1.0];
                        [lbl1 setFont:[UIFont fontWithName:@"RAJDHANI-BOLD" size:17]];
                        
                        [lbl1 setTranslatesAutoresizingMaskIntoConstraints:NO];
                        
                        [lbl1 addConstraint:[NSLayoutConstraint constraintWithItem:lbl1
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute: NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:280]];
                        
                        // Height constraint
                        [lbl1 addConstraint:[NSLayoutConstraint constraintWithItem:lbl1
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute: NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:50]];
                        
                        // CenterX constraint
                        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:lbl1
                                                                              attribute: NSLayoutAttributeCenterX
                                                                             multiplier:1
                                                                               constant:0]];
                        // Top constraint
                        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbl1
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.topLayoutGuide
                                                                              attribute: NSLayoutAttributeBottom
                                                                             multiplier:1
                                                                               constant:250]];
                        
                        CALayer * l1 = [lbl1 layer];
                        [l1 setMasksToBounds:YES];
                        [l1 setCornerRadius:8.0];
                        
                        // You can even add a border
                        [l1 setBorderWidth:3.0];
                        [l1 setBorderColor:[[UIColor colorWithRed:229/255.0 green:195/255.0 blue:101/255.0 alpha:1.0] CGColor]];
                        self.legend_pie.hidden=YES;
                    }
                }
            }
        }
        
        self.pieChartView.dataSource = self;
        self.pieChartView.delegate = self;
        self.pieChartView.animationDuration = 0.5;
        self.pieChartView.sliceColor = [UIColor whiteColor];
        self.pieChartView.borderColor = [UIColor clearColor];
        self.pieChartView.selectedSliceColor = [MCUtil flatSunFlowerColor];
        self.pieChartView.textColor = [UIColor blackColor];
        self.pieChartView.selectedTextColor = [UIColor whiteColor];
        self.pieChartView.borderPercentage = 0.01;
       
        
        
    }
    else{
        //handle received data
        self.legend_pie.hidden=YES;
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    [theme removeLoadingIcon];
    
}



-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Trainning_OperatorCount";
    [objCustomNavigation.Logout_Btn setHidden:YES];
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.Home_Btn addTarget:self action:@selector(Home_Btn:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)Home_Btn:(id)sender
{
    DashboardVC *initView = [[DashboardVC alloc]init];
    initView =  (DashboardVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboardvc"];
    [self.navigationController pushViewController:initView animated:YES];
}



-(void) showDialog:(NSString*) message andTitle:(NSString*) title{
    UIAlertView *alertDialog = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertDialog show];
}

- (NSInteger)numberOfSlicesInPieChartView:(MCPieChartView *)pieChartView {
    
    return self.values.count;
}
- (CGFloat)pieChartView:(MCPieChartView *)pieChartView valueForSliceAtIndex:(NSInteger)index {
    
    return [[self.values objectAtIndex:index] floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*)pieChartView:(MCPieChartView*)pieChartView colorForSliceAtIndex:(NSInteger)index{
    if(index == 0){
        return [UIColor colorWithRed:163/255.0 green:203/255.0 blue:62/255.0 alpha:1.0];
    }else if(index == 1){
        return  [UIColor colorWithRed:62/255.0 green:182/255.0 blue:209/255.0 alpha:1.0];
    }else if (index == 2){
        return  [UIColor colorWithRed:50/255.0 green:128/255.0 blue:204/255.0 alpha:1.0];
    }
    else if (index == 3){
        return [UIColor colorWithRed:112/255.0 green:66/255.0 blue:178/255.0 alpha:1.0];
    }
    
    
    else {
        return [UIColor colorWithRed:112/255.0 green:66/255.0 blue:178/255.0 alpha:1.0];
    }
}





- (void)pieChartView:(MCPieChartView*)pieChartView didSelectSliceAtIndex:(NSInteger)index;
{
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
        TrainningDetailsVC *destViewController =  (TrainningDetailsVC*)[storyboard instantiateViewControllerWithIdentifier:@"trainningdetails"];
        
        self.values =   [_serviceResponse objectForKey:@"CountValues"];
        // //destViewController = [CategoryVC.destViewController objectAtIndex:0];
        NSDictionary *sample=[self.values objectAtIndex:index];
        NSString*VersionStatus=[sample objectForKey:@"SessionValue"];
        //
         destViewController.VersionStatus=VersionStatus;
        [self.navigationController pushViewController:destViewController animated:YES];
    
    
    });
}
@end
