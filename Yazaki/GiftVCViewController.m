//
//  GiftVCViewController.m
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "GiftVCViewController.h"
#import "CustomNavigationVC.h"
#import "Common.h"
#import "DashboardVC.h"
#import "GiftProcessVC.h"
#import "AppDelegate.h"
#import "Theme.h"

@interface GiftVCViewController ()
{
    CustomNavigationVC *objCustomNavigation;
    Theme * theme;
}
@property(nonatomic,strong)NSMutableArray*purposeArray;
@property(nonatomic,strong) NSDictionary * puposeDict;
@property(nonatomic,strong) NSString* GiftType;
@end

@implementation GiftVCViewController
@synthesize purposeArray;
@synthesize puposeDict;
@synthesize GiftType;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    self.green_outelet_tbtn.layer.cornerRadius=105;
    self.green_outelet_tbtn.layer.masksToBounds=YES;
    self.display_greenCountValue_lbl.text=@"0";
    self.tablview.layer.borderWidth = 2.0;
    self.tablview.layer.borderColor = [UIColor colorWithRed:(223/255.0f) green:(37/255.0f) blue:(13/255.0f) alpha:1.0f].CGColor;
    [self.tablview setHidden:YES];
     theme =[[Theme alloc]init];
    
    [theme loadingIcon:self.view];
    NSString *baseURL = [NSString stringWithFormat:@"%@/GIFT/GIFTINITIALIZE",BaseURL];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        purposeArray=[serviceResponse objectForKey:@"GiftLocation"];
        
      
        
    }
    [theme removeLoadingIcon];
}



-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Gift";
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [purposeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
  puposeDict=[purposeArray objectAtIndex:indexPath.row];
    cell.textLabel.text =[puposeDict valueForKey:@"LOCATIONNAME"];
    cell.textLabel.font=[UIFont fontWithName:@"RAJDHANI-BOLD" size:cell.textLabel.font.pointSize];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.select_purpose_lbl.text =cell.textLabel.text;
    puposeDict=[purposeArray objectAtIndex:indexPath.row];
    GiftType= self.select_purpose_lbl.text;
    GiftType=[puposeDict valueForKey:@"LOCATIONCODE"];
    
    self.tablview.hidden=YES;
    
       GiftType =(GiftType == nil)?@"''":GiftType;
    
   
    [theme loadingIcon:self.view];
    
    NSString *baseURL = [NSString stringWithFormat:@"%@/GIFT/GIFTPROCESSTYPECHANGED/%@",BaseURL,GiftType];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
       NSMutableArray* LoadArray=[serviceResponse objectForKey:@"GiftProcessTotalCounts"];
        
        NSDictionary *myslot=[LoadArray objectAtIndex:0];
        self.display_greenCountValue_lbl.text=[myslot valueForKey:@"count"];
        
         NSMutableArray* LoadArray1=[serviceResponse objectForKey:@"GiftDetails"];
        
        NSDictionary *myslot1=[LoadArray1 objectAtIndex:0];
        self.validFrom_lbl.text=[myslot1 valueForKey:@"EffectiveFromstr"];
        
        // NSDictionary *myslot2=[LoadArray1 objectAtIndex:1];
        self.validTo_lbl.text=[myslot1 valueForKey:@"EffectiveTostr"];

        
        
        
    }
    [theme removeLoadingIcon];
    
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

- (IBAction)selectPuropose_btn:(id)sender {
    
    if (self.tablview.hidden ==YES) {
        
        self.tablview.hidden=NO;
        
    }
    else
        self.tablview.hidden=YES;
}
- (IBAction)Green_btn:(id)sender {
    
    if (![self.display_greenCountValue_lbl.text  isEqual: @"0"])
    {
    
      GiftType =(GiftType == nil)?@"''":GiftType;
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GiftProcessVC *initView =  (GiftProcessVC*)[storyboard instantiateViewControllerWithIdentifier:@"GiftProcess"];
    initView.GiftType = GiftType;
   
    [self.navigationController pushViewController:initView animated:YES];
    
    }
}
@end
