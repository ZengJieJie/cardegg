//
//  HISTableViewCell.h
//  Lckukynumber
//
//  Created by adin on 2024/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HISTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leixingimage;

@property (weak, nonatomic) IBOutlet UILabel *timerlab;

@property (weak, nonatomic) IBOutlet UILabel *scorelab;


@end

NS_ASSUME_NONNULL_END
