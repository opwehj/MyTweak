# 🍼 MyTweak (亲宝宝底栏净化插件)

这是一个专门为「亲宝宝」App 编写的轻量级 iOS 插件（Tweak）。它的核心目标是移除底栏上不需要的干扰按键，并自动重新排版，还你一个纯净、专注的记录空间。

## ✨ 核心功能 (Features)

* **精准屏蔽**：一键彻底移除底栏的 **“育儿”** 和 **“商城”** 按键。
* **智能重排 (Auto-Layout)**：移除按键后，底层 Hook 逻辑会接管苹果原生的 `UITabBar`，让剩余的 3 个按键（亲宝宝、消息、我的）自动等分屏幕宽度并居中，**绝不留出丑陋的空白占位**。
* **原生级顺滑**：基于底层代码级的拦截与重绘，而非粗暴的 UI 遮挡，零延迟、零性能损耗。
* **全架构支持**：强制编译为 64 位（`arm64` / `arm64e`），完美适配 iPhone 13 Pro 等机型及 iOS 14+ 乃至 iOS 16 系统。

## 📦 安装与使用 (Installation)

本项目提供已编译好的 `.dylib` 动态链接库文件，支持无越狱（巨魔）和越狱双环境。

### 方案 A：无越狱用户（TrollStore 巨魔环境）- 🌟 强烈推荐
1. 在本仓库的 **[Actions](https://github.com/)** 页面，点击最近一次打勾 `✔` 的构建记录。
2. 滑动到页面最底部，在 **Artifacts** 区域下载 `MyTweak-Dylib.zip` 压缩包。
3. 在 iPhone 的“文件”App 中解压该文件，提取出 `.dylib`。
4. 打开 **TrollFools (巨魔傻瓜)** App。
5. 在应用列表中选择「亲宝宝」，点击“注入”，选择刚才提取的 `.dylib` 文件。
6. 重新启动「亲宝宝」App，享受清爽底栏。

### 方案 B：越狱用户 (Jailbroken)
将编译生成的 `.dylib` 和 `.plist` 文件放入 `/Library/MobileSubstrate/DynamicLibraries/` 目录中，然后注销桌面（Respring）即可生效。

## 🛠 编译说明 (Build Instructions)

本项目已经配置了完善的 **GitHub Actions** 自动化编译工作流，彻底解决了官方 Theos 脚本在云端编译时触发 GitHub API 速率限制（Exit code 8）以及缺少 `ldid` 签名工具的问题。

如果你想自己修改代码并编译：
1. Fork 本仓库。
2. 修改 `Tweak.x` 中的目标按键名称（如需修改其他 App）。
3. 提交代码 (Commit & Push)。
4. GitHub 后台会自动开始构建，2 分钟后即可在 Actions
