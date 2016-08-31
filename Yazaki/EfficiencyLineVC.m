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

@interface EfficiencyLineVC ()
{
CustomNavigationVC *objCustomNavigation;
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

    
    NSString *baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/LINEEFFICIENCY/%@/%@/%@",BaseURL,selectPlantCode,fromstr,tostr];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        LineDetailArray=[serviceResponse objectForKey:@"efficiencyLines"];
        
        
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
    objCustomNavigation.lbl_titleName.text=@"";
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
