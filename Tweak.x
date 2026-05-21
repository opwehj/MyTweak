#import <UIKit/UIKit.h>

// =========================================================
// 关键修复：向编译器声明 CustomTabBar 继承自 UIView，这样就能用 frame 等属性了
// =========================================================
@interface CustomTabBar : UIView
@end

// =========================================================
// 下面是主逻辑代码
// =========================================================
%hook CustomTabBar

- (void)layoutSubviews {
    %orig; 
    
    NSMutableArray *visibleButtons = [NSMutableArray array];
    
    for (UIView *subview in self.subviews) {
        if (!subview.hidden && subview.frame.size.width > 0 && subview.frame.size.height > 20) {
            [visibleButtons addObject:subview];
        }
    }
    
    NSInteger count = visibleButtons.count;
    if (count == 0) return;
    
    CGFloat totalWidth = self.frame.size.width;
    CGFloat singleWidth = totalWidth / count; 
    
    for (NSInteger i = 0; i < count; i++) {
        UIView *button = visibleButtons[i];
        CGRect frame = button.frame;
        
        frame.origin.x = i * singleWidth; 
        frame.size.width = singleWidth;   
        
        button.frame = frame;
    }
}

%end
