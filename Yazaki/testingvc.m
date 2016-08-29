//
//  testingvc.m
//  Yazaki
//
//  Created by apple on 3/30/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import "testingvc.h"
#import "testing2.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "Common.h"
@interface testingvc ()
{
    CustomNavigationVC *objCustomNavigation;
}

@property (strong, nonatomic) NSMutableArray *TestingArray;
@end

@implementation testingvc
@synthesize STATUS;
@synthesize category;
@synthesize fromDate;
@synthesize Todate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    NSString *baseURL = [NSString stringWithFormat:@"%@/CANTEEN/CATEGORYDETAILS/%@/%@/%@/%@",BaseURL,category,STATUS,fromDate,Todate];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
 
    NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    self.TestingArray=[serviceResponse objectForKey:@"CATEGORIES"];
    
    if( [serviceResponse objectForKey:@"CATEGORIES"] == nil ||
       [[serviceResponse objectForKey:@"CATEGORIES"] isEqual:[NSNull null]] ){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        testing2 *test =  (testing2*)[storyboard instantiateViewControllerWithIdentifier:@"testing2vc"];
        
        test.passSTATUS =STATUS;
        test.passcategory=category;
        test.passfromDate=fromDate;
        test.passTodate= Todate;
      [self presentViewController:test animated:NO completion:nil];
        // do nothing
    }
        
        
    }

    
    else{
        
        
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    self.status_lbl.text=STATUS;
    self.Session_lbl.text=category;
}

-(void) showDialog:(NSString*) message andTitle:(NSString*) title{
    UIAlertView *alertDialog = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertDialog show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    return [self.TestingArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CatdetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                    forIndexPath:indexPath];
    NSDictionary *test=[self.TestingArray objectAtIndex:indexPath.row];
    cell.CatID_lbl.text = [test valueForKey:@"CATEGORY"];
    cell.Count_lbl.text=[test valueForKey:@"COUNTVALUE"];
   //// cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    testing2 *test =  (testing2*)[storyboard instantiateViewControllerWithIdentifier:@"testing2vc"];
    
    // //destViewController = [CategoryVC.destViewController objectAtIndex:0];
    NSDictionary *sample=[self.TestingArray objectAtIndex:indexPath.row];
    NSString*catID=[sample objectForKey:@"CATEGORYID"];
    NSString*category1=[sample objectForKey:@"CATEGORY"];
    
    test.passcategory1 = category1;
    test.passcatID = catID;
    test.passSTATUS =STATUS;
    test.passcategory=category;
    test.passfromDate=fromDate;
    test.passTodate= Todate;
    test.selectPlantCode=_selectPlantCode;

 [self.navigationController pushViewController:test animated:YES];
//[[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
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


@end
