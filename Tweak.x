#import <UIKit/UIKit.h>

// =================================================================
// 注意：请使用 FLEX 查看到的真实底栏父视图类名替换这里的 "CustomTabBar"
// =================================================================
%hook CustomTabBar

- (void)layoutSubviews {
    %orig; // 首先让系统执行原有的均分排列逻辑
    
    // 1. 收集当前所有「未被隐藏」且属于按键的子视图
    NSMutableArray *visibleButtons = [NSMutableArray array];
    
    for (UIView *subview in self.subviews) {
        // 过滤条件：没被隐藏、宽度大于0、高度足够（排除掉背景图、红点或分割线等微小视图）
        // 如果能确定按键的类名，最好加上：[subview isKindOfClass:%c(按键类名)]
        if (!subview.hidden && subview.frame.size.width > 0 && subview.frame.size.height > 20) {
            [visibleButtons addObject:subview];
        }
    }
    
    NSInteger count = visibleButtons.count;
    if (count == 0) return;
    
    // 2. 重新计算平铺参数
    CGFloat totalWidth = self.frame.size.width;
    CGFloat singleWidth = totalWidth / count; // 动态计算 剩余可见按键 的均分宽度
    
    // 3. 重新调整每个可见按键的 Frame 坐标
    for (NSInteger i = 0; i < count; i++) {
        UIView *button = visibleButtons[i];
        CGRect frame = button.frame;
        
        frame.origin.x = i * singleWidth; // 重新链接 X 轴，使其紧密排列
        frame.size.width = singleWidth;   // 动态更新宽度，使其拉伸填满
        
        button.frame = frame;
    }
}

%end
