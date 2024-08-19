//
//  MeHomeViewController.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/14.
//

#import "MeHomeViewController.h"
#import "MemoryViewController.h"
#import "SettingsViewController.h"
@interface MeHomeViewController ()

@end

@implementation MeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)startbutton:(id)sender {
    
    MemoryViewController * vc=[[MemoryViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)setingbutton:(id)sender {
    SettingsViewController * vc=[[SettingsViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
   
}


- (IBAction)mysharuibutton:(id)sender {
    NSURL *urlToShare = [NSURL URLWithString:@"https://apps.apple.com/app/PattiEggGame/id6642676691"];
    
 
    NSMutableArray * mutableArrayab = [NSMutableArray array];
    
    
    [mutableArrayab addObject:urlToShare];

  
    // 创建分享vc
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:mutableArrayab applicationActivities:nil];
   
    
    [self presentViewController:activityVC animated:YES completion:nil];
     // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
       
    };
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
