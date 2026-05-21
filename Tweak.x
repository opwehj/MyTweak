#import <UIKit/UIKit.h>

// Hook 苹果原生的底栏类
%hook UITabBar

- (void)layoutSubviews {
    %orig; // 先让系统自己排版一遍，这样才会有初始坐标
    
    NSMutableArray *visibleButtons = [NSMutableArray array];
    
    // 1. 遍历底栏里的所有子视图
    for (UIView *subview in self.subviews) {
        
        // 苹果底栏的按键类名是内部私有的 UITabBarButton
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITabBarButton"]) {
            
            BOOL shouldHide = NO;
            
            // 往按键内部找，看看有没有带“育儿”或“商城”字样的标签
            for (UIView *deepView in subview.subviews) {
                if ([deepView isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)deepView;
                    if ([label.text isEqualToString:@"育儿"] || [label.text isEqualToString:@"商城"]) {
                        shouldHide = YES;
                        break;
                    }
                }
            }
            
            if (shouldHide) {
                // 如果是我们要干掉的按键，彻底隐藏，并把坐标设为0防止占位
                subview.hidden = YES;
                subview.frame = CGRectZero;
                subview.userInteractionEnabled = NO;
            } else {
                // 如果是需要保留的按键，加到可见数组里
                subview.hidden = NO;
                [visibleButtons addObject:subview];
            }
        }
    }
    
    // 2. 重新排版剩下的按键
    NSInteger count = visibleButtons.count;
    if (count > 0) {
        CGFloat totalWidth = self.frame.size.width;
        CGFloat singleWidth = totalWidth / count; // 动态计算剩余按键的等分宽度
        
        // 关键一步：按照原本的 X 坐标排序，保证“亲宝宝”、“消息”、“我的”顺序不乱
        [visibleButtons sortUsingComparator:^NSComparisonResult(UIView *v1, UIView *v2) {
            if (v1.frame.origin.x < v2.frame.origin.x) return NSOrderedAscending;
            if (v1.frame.origin.x > v2.frame.origin.x) return NSOrderedDescending;
            return NSOrderedSame;
        }];
        
        // 重新分配 X 轴坐标和宽度，让它们平铺居中
        for (NSInteger i = 0; i < count; i++) {
            UIView *button = visibleButtons[i];
            CGRect frame = button.frame;
            frame.origin.x = i * singleWidth;
            frame.size.width = singleWidth;
            button.frame = frame;
        }
    }
}

%end
