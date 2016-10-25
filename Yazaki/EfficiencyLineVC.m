//
//  EfficiencyLineVC.m
//  Yazaki
//
//  Created by Lexicon on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "EfficiencyLineVC.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "EffeciencyCell.h"
#import "AppDelegate.h"
#import "Theme.h"

@interface EfficiencyLineVC ()
{
   CustomNavigationVC *objCustomNavigation;
    AppDelegate * appDelegate;
    Theme * theme;
    
}
@property (strong, nonatomic) NSMutableArray*LineDetailArray;
@end

@implementation EfficiencyLineVC
@synthesize fromstr;
@synthesize tostr;
@synthesize selectPlantCode;
@synthesize LineDetailArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customnavigationmethod];
    
    LineDetailArray =[[NSMutableArray alloc]init];
    theme =[[Theme alloc]init];
    
    [theme loadingIcon:self.view];
    //[appDelegate showLoading];
//    NSString *baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/LINEEFFICIENCY/%@/%@/%@",BaseURL,selectPlantCode,fromstr,tostr];
//    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLResponse *response;
//    NSError *error;
//    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (responseData != nil) {
//        
//        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        LineDetailArray=[serviceResponse objectForKey:@"efficiencyLines"];
//        
//        
//    }
//    else{
//        
//        
//        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
//        
//    }
//      [theme removeLoadingIcon];
    
}

-(void) viewWillAppear:(BOOL)animated
{
[NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(loadingWebservice)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)loadingWebservice
{
    NSString *baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/LINEEFFICIENCY/%@/%@/%@",BaseURL,selectPlantCode,fromstr,tostr];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        LineDetailArray=[serviceResponse objectForKey:@"efficiencyLines"];
        [self.tablview reloadData];
        [theme removeLoadingIcon];
        
    }
    else{
        
        
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    [theme removeLoadingIcon];

}

-(void) showDialog:(NSString*) message andTitle:(NSString*) title{
    UIAlertView *alertDialog = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertDialog show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    return [LineDetailArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EffeciencyCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                               forIndexPath:indexPath];
    NSDictionary *test=[LineDetailArray objectAtIndex:indexPath.row];
    cell.plantCode_lbl.text = [test valueForKey:@"PlantCode"];
    cell.shed_lbl.text=[test valueForKey:@"SHED"];
    cell.lineName_lbl.text=[test valueForKey:@"LineCode"];
     cell.effieicny_lbl.text=[test valueForKey:@"DirectEfficiency"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=[NSString stringWithFormat:@"%@_Details",self.Tittle];
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


-(void)loadingIcon
{
    UIView * loadingview = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2, (self.view.frame.size.height)/2, 37, 37)];
    
    [loadingview.layer setCornerRadius:5.0];
    
    [loadingview setBackgroundColor:[UIColor redColor]];
    
    //Enable maskstobound so that corner radius would work.
    
    [loadingview.layer setMasksToBounds:YES];
    
    //Set the corner radius
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [activityView setFrame:CGRectMake(7, 7, 37, 37)];
    
    [activityView setHidesWhenStopped:YES];
    
    [activityView startAnimating];
    
    [loadingview addSubview:activityView];
    [self.view addSubview:loadingview];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
