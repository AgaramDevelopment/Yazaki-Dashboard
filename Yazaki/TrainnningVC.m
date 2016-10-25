//
//  TrainnningVC.m
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "TrainnningVC.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "Common.h"
#import "TrainningPieChartVC.h"
#import "Theme.h"


@interface TrainnningVC ()
{
    CustomNavigationVC *objCustomNavigation;
    Theme * theme;
}
@property(nonatomic,strong)NSMutableArray*TrainningArray;

@end

@implementation TrainnningVC
@synthesize TrainningArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    self.trainning_Outletbtn.layer.cornerRadius=120;
    self.trainning_Outletbtn.layer.masksToBounds=YES;
    
    TrainningArray=[[NSMutableArray alloc]init];
    theme =[[Theme alloc]init];
    [theme loadingIcon:self.view];
    
    NSString *baseURL = [NSString stringWithFormat:@"%@/TRAINING/TRAININGDASHBOARDINITIALIZE",BaseURL];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
      TrainningArray=[serviceResponse objectForKey:@"CountValues"];
        
          NSDictionary *myslot=[TrainningArray objectAtIndex:0];
        NSString *test=[myslot valueForKey:@"CountValue"];
             self.traingDisplay_lbl.text=  [NSString stringWithFormat:@"%@",test];
        
    }
    [theme removeLoadingIcon];


}


-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=self.Tittle;
    objCustomNavigation.Logout_Btn.hidden=YES;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)traingTouch_btn:(id)sender {
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (![self.traingDisplay_lbl.text  isEqual: @"0"])
    {
    TrainningPieChartVC *initView = [[TrainningPieChartVC alloc]init];
    initView =  (TrainningPieChartVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"TrainningChart"];
    [self.navigationController pushViewController:initView animated:YES];
    
    }
}
@end
