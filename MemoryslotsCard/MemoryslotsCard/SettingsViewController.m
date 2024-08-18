//
//  SettingsViewController.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/14.
//

#import "SettingsViewController.h"
#import "PriViewController.h"
#import "UserOpinionViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clearbtn:(UIButton *)sender {
    
   
      
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                    message:@"Are you sure you want to clear the cache?"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
           
          
           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
               
              
               
           }];
           
        
           [alertController addAction:okAction];
           
          
           [self presentViewController:alertController animated:YES completion:nil];

}

- (IBAction)privacy:(id)sender {
    PriViewController * vc=[[PriViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (IBAction)useropinon:(id)sender {
    
    UserOpinionViewController * vc=[[UserOpinionViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
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
