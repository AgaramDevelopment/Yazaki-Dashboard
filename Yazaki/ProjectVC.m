//
//  ProjectVC.m
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ProjectVC.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "ProjectCell.h"

@interface ProjectVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objProjectArray;
}

@end

@implementation ProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    objProjectArray=[[NSMutableArray alloc]init];
    [self webService:self.projectCode :self.taskStatus];
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"";
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

-(void)webService :(NSString *) projectcode:(NSString *) taskstatus
{
    NSString * baseURL = [NSString stringWithFormat:@"%@/PROJECTMANAGEMENT/FETCHPROJECTTASKDETAILSBYTASKSTATUS/%@/%@",BaseURL,projectcode,taskstatus];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        objProjectArray =   [_serviceResponse objectForKey:@"ProjectTask"];
        
    }
    else{
        //handle received data
        //self.legend_ok_view.hidden=YES;
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    
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
    
    return [objProjectArray count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ProjectCell";
    
    ProjectCell * cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary * ProjectDic =[objProjectArray objectAtIndex:indexPath.row];
    // NSDictionary * customername =[CustomerArray objectAtIndex:indexPath.row];
    
    cell.lbl_phaseName.text =[ProjectDic valueForKey:@"PHASENAME"];
    cell.lbl_Department.text = [ProjectDic valueForKey:@"DEPARTMENTNAME"];
    cell.lbl_activity.text =[ProjectDic valueForKey:@"ACTIVITYCODE"];
    cell.lbl_activityName.text =[ProjectDic valueForKey:@"ACTIVITYNAME"];
    cell.lbl_Task.text =[ProjectDic valueForKey:@"TASKCODE"];
    cell.lbl_TaskName.text =[ProjectDic valueForKey:@"TASKNAME"];
    cell.lbl_ResponsEmployee.text =[ProjectDic valueForKey:@"RESEMPLOYEECODE"];
    
    return cell;
}

- (void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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
