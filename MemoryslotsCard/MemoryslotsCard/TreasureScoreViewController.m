//
//  TreasureScoreViewController.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/16.
//

#import "TreasureScoreViewController.h"
#import "MemoryViewController.h"
@interface TreasureScoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *coslab;
@property (weak, nonatomic) IBOutlet UIView *imageview;
@property (nonatomic, strong) NSMutableArray *imagearray;
@property(assign,nonatomic) int coinsint;
@property(assign,nonatomic) int countcoin;
@end

@implementation TreasureScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *retrievedString = [defaults stringForKey:@"mypoints"];
    self.coinsint=[retrievedString intValue];
    self.coslab.text=[NSString stringWithFormat:@"%d",self.coinsint];
    self.countcoin=0;
    
    self.imagearray = [NSMutableArray arrayWithArray:@[@1, @1, @1, @1, @2, @1, @0, @0, @0, @0, @0, @0, @0, @0, ]];
    for (NSUInteger i = self.imagearray.count - 1; i > 0; i--) {
        NSUInteger j = arc4random_uniform((uint32_t)i + 1);
        [self.imagearray exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    int matrix[2][7];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 7; j++) {
            matrix[i][j] = [self.imagearray[i * 7 + j] intValue];
        }
    }
    [self creattrbutton:self.imageview];
    NSLog(@"%@",self.imagearray);
}
- (IBAction)backbutton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%d",self.coinsint] forKey:@"mypoints"];
    [defaults synchronize];
     MemoryViewController *vcA = (MemoryViewController *)self.presentingViewController;
        
        [self dismissViewControllerAnimated:YES completion:^{
           
            [vcA disupdatcoins];
        }];
}

- (void)creattrbutton:(UIView *)view {
    
    CGFloat spacing = 5;
    CGFloat buttonWidth = (view.frame.size.width - 6 * spacing) / 7;
    CGFloat buttonHeight = (view.frame.size.height - 1 * spacing) / 2;
    
    
    for (int row = 0; row < 2; row++) {
        for (int col = 0; col < 7; col++) {
            
            CGFloat x = col * (buttonWidth + spacing);
            CGFloat y = row * (buttonHeight + spacing);
            
            
            NSInteger index = row * 7 + col;
            NSString *number = self.imagearray[index];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
            
            
            button.tag = [number intValue]; // 设置 tag 以便于后续操作
           
            if (button.tag>0) {
                [button setBackgroundImage:[UIImage imageNamed:@"backimage"] forState:UIControlStateNormal];
                NSLog(@"%ld",button.tag);
                
            }else{
                button.hidden=YES;
            }
            [button addTarget:self action:@selector(imagebut:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
    
}

- (void)imagebut:(UIButton *)sender {
    self.countcoin++;
    [UIView transitionWithView:sender
                         duration:0.5
                          options:UIViewAnimationOptionTransitionFlipFromRight
                       animations:^{
        sender.userInteractionEnabled = NO;
        if (sender.tag==1) {
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"01"]] forState:UIControlStateNormal];
        }else{
            self.coinsint=self.coinsint+10;
            self.coslab.text=[NSString stringWithFormat:@"%d",self.coinsint];
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"00001"]] forState:UIControlStateNormal];
            NSString *tis=@"";
            switch (self.countcoin) {
                case 1:
                    tis=[NSString stringWithFormat:@"You are incredibly lucky, as if everything you touch turns to gold！"];
                    break;
                case 2:
                    tis=[NSString stringWithFormat:@"You're very lucky. It's like winning the lottery twice！"];
                    break;
                case 3:
                    tis=[NSString stringWithFormat:@"Your luck is average！"];
                    break;
                case 4:
                    tis=[NSString stringWithFormat:@" You often seem to be out of luck！"];
                    break;
                case 5:
                    tis=[NSString stringWithFormat:@" You really have no luck at all.  Do you feel bad luck everywher！"];
                    break;
                case 6:
                    tis=[NSString stringWithFormat:@" Congratulations. You're the one with the worst luck！"];
                    break;
                default:
                    break;
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                        message:tis
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
               
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
               }];
               
               [alertController addAction:okAction];
               
               [self presentViewController:alertController animated:YES completion:nil];
            
        }
       
                         
                       }
                       completion:^(BOOL finished) {
                          
                       }];
    
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
