//
//  DashboardVC.m
//  Yazaki
//
//  Created by apple on 4/1/16.
//  Copyright (c) 2016 apple. All rights reserved.
//


#import "DashboardVC.h"
#import "AppDelegate.h"
#import "CustomNavigationVC.h"
#import "DashBoardCell.h"
#import "Common.h"
#import "HomeMonthVC.h"
#import "HOMEVC.h"
#import "LoginVC.h"
#import "QuoteMgtVC.h"
#import "TrainnningVC.h"
#import "ProjectMgtVC.h"
#import "GiftVCViewController.h"

@interface DashboardVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * dashBoard_Array;
}
@end

@implementation DashboardVC

- (void)viewDidLoad {

    [super viewDidLoad];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 225, 20, 30)];
    [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    spinner.color = [UIColor blackColor];
    [self.view addSubview:spinner];
    [self customnavigationmethod];
    [objCustomNavigation.Home_Btn setHidden:YES];
    [objCustomNavigation.Btn_Back setHidden:YES];
    [objCustomNavigation.Logout_Btn addTarget:self action:@selector(didClickLogoutBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    dashBoard_Array =[[NSMutableArray alloc]init];
    dashBoard_Array =self.dashBoardList;
   
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LoginUserRecord"] != nil)
    {
        dashBoard_Array=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginUserRecord"];
    }

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate hideLoading];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dashBoard_Array.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(IS_IPHONE5)
    {
        return UIEdgeInsetsMake(20,10, 10, 20);
    }
    else
    {
    return UIEdgeInsetsMake(10, 50, 10, 50);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 145);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashBoardCell *cell = (DashBoardCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"dashCell" forIndexPath:indexPath];
    
    NSDictionary *list= [dashBoard_Array objectAtIndex:indexPath.row];
    cell.iconName_Lbl.text = [list valueForKey:@"DISPLAYNAME"];
    
    cell.common_View.layer.cornerRadius=10;
    //cell.common_View.backgroundColor=[UIColor colorWithRed:(223/255.0f) green:(37/255.0f) blue:(13/255.0f) alpha:1.0f];
    NSString *imgName_Str;
    
    if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"2"])
    {
        
        imgName_Str = @"canteenImg";
        cell.common_View.backgroundColor=[UIColor colorWithRed:239/255.0 green:83/255.0 blue:66/255.0 alpha:1.0];
    }
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"3"])
    {
        
        imgName_Str = @"productionImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:148/255.0 green:89/255.0 blue:167/255.0 alpha:1.0];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"4"])
    {
               imgName_Str = @"scrapImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:74/255.0 green:175/255.0 blue:93/255.0 alpha:1.0];
    }

    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"5"])
    {
        
        imgName_Str = @"efficiencyImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:55/255.0 green:68/255.0 blue:77/255.0 alpha:1.0];
    }
    
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"6"])
    {
        
        imgName_Str = @"quoteIMg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:43/255.0 green:183/255.0 blue:240/255.0 alpha:1.0];
    }
    
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"7"])
    {
        
        imgName_Str = @"trainingImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:65/255.0 green:82/255.0 blue:175/255.0 alpha:1.0];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"8"])
    {
        
        imgName_Str = @"gatepassImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:11/255.0 green:161/255.0 blue:89/255.0 alpha:1.0];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"9"])
    {
        
        imgName_Str = @"giftImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:45/255.0 green:137/255.0 blue:190/255.0 alpha:1.0];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"10"])
    {
        
        imgName_Str = @"projectImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:255/255.0 green:144/255.0 blue:54/255.0 alpha:1.0];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"12"])
    {
        imgName_Str = @"attendanceImg";
         cell.common_View.backgroundColor=[UIColor colorWithRed:21/255.0 green:188/255.0 blue:175/255.0 alpha:1.0];
    }

    
    cell.icon_Img.image    =[UIImage imageNamed:imgName_Str];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSDictionary *list= [dashBoard_Array objectAtIndex:indexPath.row];
    
    NSString * selectOptionTye= [list valueForKey:@"DASHBOARDID"];
    
    if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"2"]||[[list valueForKey:@"DASHBOARDID"] isEqualToString: @"3"]||[[list valueForKey:@"DASHBOARDID"] isEqualToString: @"4"] ||[[list valueForKey:@"DASHBOARDID"] isEqualToString: @"5"]||[[list valueForKey:@"DASHBOARDID"] isEqualToString: @"8"])
    {
    
    UITabBarController *initView =  (UITabBarController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Homevc"];

     HomeMonthVC * destViewController = [initView.viewControllers objectAtIndex:0];
     destViewController.selectType = selectOptionTye;
   
    HOMEVC *destViewController1 =[initView.viewControllers objectAtIndex:1];
    destViewController1.selectType = selectOptionTye;
    
    [self.navigationController pushViewController:initView animated:YES];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"6"])
    {
        QuoteMgtVC * objQuoteMgtVC =  (QuoteMgtVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"QuoteMgtvc"];
        objQuoteMgtVC.selectType =selectOptionTye;
        [self.navigationController pushViewController:objQuoteMgtVC animated:YES];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"7"])
    {
        TrainnningVC * objtrainVC =  (TrainnningVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Trainningid"];
        objtrainVC.selectType =selectOptionTye;
        [self.navigationController pushViewController:objtrainVC animated:YES];
    }
    
    else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"9"])
    {
        
        GiftVCViewController * objGiftVC =  (GiftVCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GiftID"];
        objGiftVC.selectType =selectOptionTye;
        [self.navigationController pushViewController:objGiftVC animated:YES];
    }
    
    
    else if ([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"10"])
    {
        ProjectMgtVC * objProjectMgtVC =  (ProjectMgtVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProjectMgtvc"];
       
        [self.navigationController pushViewController:objProjectMgtVC animated:YES];
    }
     else if([[list valueForKey:@"DASHBOARDID"] isEqualToString: @"9"])
     {
         GiftVCViewController * objtrainVC =  (GiftVCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GiftID"];
         objtrainVC.selectType =selectOptionTye;
         [self.navigationController pushViewController:objtrainVC animated:YES];

     }
    
    
}

-(IBAction)didClickLogoutBtnAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginUserRecord"];
    
    LoginVC * objLoginvc = [[LoginVC alloc]init];
    objLoginvc =  (LoginVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"loginvc"];
    [self.navigationController pushViewController:objLoginvc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"DASHBOARD";
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Canteen_btn:(id)sender {
    
    
  
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    UITabBarController *initView =  (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"Homevc"];
    [self.navigationController pushViewController:initView animated:YES];
}
@end
