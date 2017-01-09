//
//  ProductionVC.m
//  Yazaki
//
//  Created by Lexicon on 29/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ProductionVC.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "ProdcutionCell.h"
#import "ProductionDetailsVC.h"
#import "Theme.h"


@interface ProductionVC ()


{
    CustomNavigationVC *objCustomNavigation;
    Theme * theme;
}

@property (strong, nonatomic) NSMutableArray *productionArray;
@end

@implementation ProductionVC
@synthesize selectPlantCode;
@synthesize FromStr;
@synthesize  ToStr;
@synthesize productionArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    productionArray =[[NSMutableArray alloc]init];
    
    theme =[[Theme alloc]init];
    [theme loadingIcon:self.view];
    selectPlantCode=(selectPlantCode==nil)?@"select":selectPlantCode;
 NSString *baseURL = [NSString stringWithFormat:@"%@/PRODUCTION/BOXDETAILED/%@/%@/%@",BaseURL,selectPlantCode,FromStr,ToStr];
 NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        self.productionArray=[serviceResponse objectForKey:@"BOXDETAILS"];
        
        
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
    return [productionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ProdcutionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                    forIndexPath:indexPath];
    NSDictionary *test=[productionArray objectAtIndex:indexPath.row];
    cell.Plant_lbl.text = [test valueForKey:@"PLANTNAME"];
    cell.lineName_lbl.text=[test valueForKey:@"LINENAME"];
    cell.ActualQuality_lbl.text=[test valueForKey:@"ACTUALQTY"];
    cell.PlanQuality_Lbl.text=[test valueForKey:@"PLANQTY"];
   cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductionDetailsVC *test =  (ProductionDetailsVC*)[storyboard instantiateViewControllerWithIdentifier:@"ProductDetails"];
    
    // //destViewController = [CategoryVC.destViewController objectAtIndex:0];
    NSDictionary *sample=[productionArray objectAtIndex:indexPath.row];
    NSString*LineName=[sample valueForKey:@"PLANTNAME"];
    NSString*PlantName=[sample valueForKey:@"LINENAME"];
    NSString*lineCode=[sample valueForKey:@"LINECODE"];
      NSString*PlantCode=[sample valueForKey:@"PLANTCODE"];
    
    test.LineName = LineName;
    test.PlantName = PlantName;
    test.lineCode =lineCode;
    test.PlantCode=PlantCode;
    test.FromStr=FromStr;
    test.ToStr= ToStr;

    
    [self.navigationController pushViewController:test animated:YES];
    //[[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}


-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=[NSString stringWithFormat:@"%@_Detailed line list",self.Tittle];
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
