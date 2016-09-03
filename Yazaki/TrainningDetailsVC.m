//
//  TrainningDetailsVC.m
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "TrainningDetailsVC.h"
#import "CustomNavigationVC.h"
#import "Common.h"
#import "DashboardVC.h"
#import "TrainingCell.h"

@interface TrainningDetailsVC ()
{
    CustomNavigationVC *objCustomNavigation;
}
@property (strong, nonatomic) NSMutableArray *TrainnigArray;
@end

@implementation TrainningDetailsVC
@synthesize TrainnigArray;
@synthesize VersionStatus;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    TrainnigArray =[[NSMutableArray alloc]init];
    
    
    NSString *baseURL = [NSString stringWithFormat:@"%@/TRAINING/TRAININGDASHBOARDDETAILSLIST/%@",BaseURL,VersionStatus];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        TrainnigArray=[serviceResponse objectForKey:@"TrainingList"];
        
        
    }
    
    
    else{
        
        
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    
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
    return [TrainnigArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TrainingCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                          forIndexPath:indexPath];
    NSDictionary *test=[TrainnigArray objectAtIndex:indexPath.row];
    cell.Operator_lbl.text = [test valueForKey:@"OperatorID"];
    cell.employeeName_lbl.text=[test valueForKey:@"EmployeeName"];
    cell.EduQulification_lbl.text=[test valueForKey:@"EducationQualification"];
    cell.dateofjoinning_lbl.text=[test valueForKey:@"DateOfJoining"];
    cell.department_lbl.text=[test valueForKey:@"DepartmentName"];
    cell.year0fpaa_lbl.text=[test valueForKey:@"YearOfPassout"];
  
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}








-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Training_Detailed List";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
