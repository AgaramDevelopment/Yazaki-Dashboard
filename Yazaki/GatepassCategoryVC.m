//
//  GatepassCategoryVC.m
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "GatepassCategoryVC.h"
#import "CustomNavigationVC.h"
#import "Common.h"
#import "DashboardVC.h"
#import "GPCategoryCell.h"
#import "GPDetailVC.h"
#import "AppDelegate.h"
#import "Theme.h"

@interface GatepassCategoryVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * CategoryArray;
    AppDelegate * appDelegate;
}

@end

@implementation GatepassCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    CategoryArray=[[NSMutableArray alloc]init];
    [self webService];
}
-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Gate Pass_Catagory List";
    [objCustomNavigation.Logout_Btn setHidden:YES];
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.Home_Btn addTarget:self action:@selector(Home_Btn:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)Home_Btn:(id)sender
{
    DashboardVC *initView = [[DashboardVC alloc]init];
    initView =  (DashboardVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboardvc"];
    [self.navigationController pushViewController:initView animated:YES];
}

-(void)webService
{
    Theme * theme =[[Theme alloc]init];
    [theme loadingIcon:self.view];
    NSString * baseURL = [NSString stringWithFormat:@"%@/GATEENTRY/GATEENTRYCATEGORY/%@/%@/%@/%@/%@",BaseURL,self.plantCode,self.GateCode,self.fromDate,self.Todate,self.vistorType];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        CategoryArray =   [_serviceResponse objectForKey:@"Categories"];
        
    }
    else{
        //handle received data
        //self.legend_ok_view.hidden=YES;
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
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [CategoryArray count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"GPCategoryCell";
    
    GPCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[GPCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary * ProjectDic =[CategoryArray objectAtIndex:indexPath.row];
   // NSMutableArray * Categories =[ProjectDic valueForKey:@"Categories"];
    
     //NSDictionary * CategoryDic =[Categories objectAtIndex:indexPath.row];
    cell.objCount_lbl.text =[ProjectDic valueForKey:@"CountValue"];
    cell.objType_lbl.text = [ProjectDic valueForKey:@"Category"];
   
    return cell;
}

- (void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GPDetailVC * objGPDetailVC = [[GPDetailVC alloc]init];
    objGPDetailVC =  (GPDetailVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"GPDetailvc"];
    NSDictionary * CategoryDic =[CategoryArray objectAtIndex:indexPath.row];
    objGPDetailVC.plantCode=self.plantCode;
    objGPDetailVC.GateCode =self.GateCode;
    objGPDetailVC.fromDate = self.fromDate;
    objGPDetailVC.Todate = self.Todate;
    objGPDetailVC.vistorType=self.vistorType;
    objGPDetailVC.vistorID=[CategoryDic valueForKey:@"VisitorType"];

    [self.navigationController pushViewController:objGPDetailVC animated:YES];
    
    
}


-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
