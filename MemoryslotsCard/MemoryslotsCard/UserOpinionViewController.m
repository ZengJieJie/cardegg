//
//  UserOpinionViewController.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/18.
//

#import "UserOpinionViewController.h"

@interface UserOpinionViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textv;
@property (weak, nonatomic) IBOutlet UIButton *backbbtn;
@property (nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation UserOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textv.delegate = self;
    self.textv.tintColor = [UIColor whiteColor];
   
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, self.textv.frame.size.width - 10, 20)];
        self.placeholderLabel.text = @"Please enter your comments";
        self.placeholderLabel.textColor = [UIColor whiteColor];
        self.placeholderLabel.font =[UIFont boldSystemFontOfSize:22];
        
       
        [self.textv addSubview:self.placeholderLabel];
        
       
        self.placeholderLabel.hidden = self.textv.text.length > 0;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(UIButton *)sender {
    if (self.textv.text.length>0) {
        sender.userInteractionEnabled = NO;
        self.backbbtn.userInteractionEnabled=NO;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            self.backbbtn.userInteractionEnabled=YES;
            sender.userInteractionEnabled = YES;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                        message:@"User comments are submitted successfully"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
               
              
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                   
                   self.textv.text=@"";
                   
               }];
               
            
               [alertController addAction:okAction];
               
              
               [self presentViewController:alertController animated:YES completion:nil];
          
        });
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                    message:@"Please enter user comments"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
           
          
           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
               
              
               
           }];
           
        
           [alertController addAction:okAction];
           
          
           [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden = YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length > 0;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length > 0;
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
