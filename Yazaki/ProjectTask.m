//
//  ProjectTask.m
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ProjectTask.h"

@interface ProjectTask ()

@end

@implementation ProjectTask

- (void)viewDidLoad {
    [super viewDidLoad];
    self.project_lbl.text =self.projectname;
    self.Totaltask_lbl.text =self.totalTask;
    self.completedTask_lbl.text=self.completedTask;
    self.pendingTask_lbl.text=self.pendingTask;
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
