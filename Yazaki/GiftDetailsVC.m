//
//  GiftDetailsVC.m
//  Yazaki
//
//  Created by Lexicon on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "GiftDetailsVC.h"
#import "GiftDetailsCell.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "AppDelegate.h"
#import "Theme.h"


@interface GiftDetailsVC ()
{
    CustomNavigationVC *objCustomNavigation;
    AppDelegate * appDelegate;
}
@property (strong, nonatomic) NSMutableArray*GiftDetailsArray;
@end

@implementation GiftDetailsVC
@synthesize GiftDetailsArray;
@synthesize GiftType;
@synthesize categoryID;
@synthesize categoryname;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    self.category_lbl.text=categoryname;
    GiftDetailsArray =[[NSMutableArray alloc]init];
    Theme * theme =[[Theme alloc]init];
    [theme loadingIcon:self.view];
    NSString *baseURL = [NSString stringWithFormat:@"%@/GIFT/GIFTPROCESSDETAILED/%@/%@",BaseURL,GiftType,categoryID];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        GiftDetailsArray=[serviceResponse objectForKey:@"GiftProcess"];
        
        
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
    return [GiftDetailsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GiftDetailsCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                           forIndexPath:indexPath];
    NSDictionary *test=[GiftDetailsArray objectAtIndex:indexPath.row];
    cell.id_lbl.text = [test valueForKey:@"ID"];
    cell.name_lbl.text=[test valueForKey:@"NAME"];
     cell.accesstime_lbl.text=[test valueForKey:@"ACCESSTIME"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}






-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Gift_Detailed List";
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
