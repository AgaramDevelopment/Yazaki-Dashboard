//
//  ProjectMgtVC.m
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ProjectMgtVC.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "ProjectMgtCell.h"
#import "ProjectTask.h"
#import "Theme.h"


@interface ProjectMgtVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objProjectMgtArray;
    Theme * theme;
}

@end

@implementation ProjectMgtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    objProjectMgtArray =[[NSMutableArray alloc]init];
    [self webService];
    // Do any additional setup after loading the view.
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=self.Tittle;
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
    theme =[[Theme alloc]init];
    [theme  loadingIcon:self.view];
    NSString * baseURL = [NSString stringWithFormat:@"%@/PROJECTMANAGEMENT/INITIALIZEPROJECTMANGEMENT",BaseURL];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        objProjectMgtArray =   [_serviceResponse objectForKey:@"AllProjectDetails"];
        
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
    
    return [objProjectMgtArray count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ProjectMgtCell";
    
    ProjectMgtCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[ProjectMgtCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary * ProjectDic =[objProjectMgtArray objectAtIndex:indexPath.row];
    // NSDictionary * customername =[CustomerArray objectAtIndex:indexPath.row];
    
    cell.lbl_projectcode.text =[ProjectDic valueForKey:@"PROJECTCODE"];
    cell.lbl_projectname.text = [ProjectDic valueForKey:@"PROJECTNAME"];
    cell.lbl_Customercode.text =[ProjectDic valueForKey:@"CUSTOMERNAME"];
    cell.lbl_Startdate.text =[ProjectDic valueForKey:@"PROJECTSTARTDATE"];
    cell.lbl_Enddate.text =[ProjectDic valueForKey:@"PROJECTENDDATE"];
    cell.lbl_Totaltask.text =[ProjectDic valueForKey:@"TOTALTASK"];
    cell.lbl_Completedtask.text =[ProjectDic valueForKey:@"COMPLETEDTASK"];
    cell.lbl_Pendingtask.text =[ProjectDic valueForKey:@"PENDINGTASK"];
    return cell;
}

- (void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProjectTask * objQuoteAmount = [[ProjectTask alloc]init];
    objQuoteAmount =  (ProjectTask *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProjectTask"];
    NSDictionary * AmountDic =[objProjectMgtArray objectAtIndex:indexPath.row];
    objQuoteAmount.projectname=[AmountDic valueForKey:@"PROJECTNAME"];
    objQuoteAmount.totalTask =[AmountDic valueForKey:@"TOTALTASK"];
    objQuoteAmount.completedTask = [AmountDic valueForKey:@"COMPLETEDTASK"];
    objQuoteAmount.pendingTask = [AmountDic valueForKey:@"PENDINGTASK"];
    objQuoteAmount.objprojectcode=[AmountDic valueForKey:@"PROJECTCODE"];
    [self.navigationController pushViewController:objQuoteAmount animated:YES];
    
    
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
