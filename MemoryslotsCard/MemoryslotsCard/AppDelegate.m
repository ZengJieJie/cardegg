//
//  AppDelegate.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/14.
//

#import "AppDelegate.h"
#import "MeHomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    

 
    MeHomeViewController *navigationController =[[MeHomeViewController alloc]init];
    
    
  
    self.window.rootViewController = navigationController;

   
    [self.window makeKeyAndVisible];
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSArray *myArrayKey = [defaults arrayForKey:@"myArrayKey"];
    NSString *mypoints = [defaults stringForKey:@"mypoints"];
    if (!myArrayKey) {
        NSArray *array = @[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"];

        [defaults setObject:array forKey:@"myArrayKey"];
    }
    if (!mypoints) {
        NSString *myString = @"120";
        [defaults setObject:myString forKey:@"mypoints"];
    }
    [defaults synchronize];
    return YES;
}





@end
