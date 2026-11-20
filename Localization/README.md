# vreader 简体中文界面（zh-Hans）

本目录提供 vreader iOS 的简体中文界面文案。上游 `lllyys/vreader` 没有本地化层
（无 `.lproj` / `Localizable` / String Catalog），界面文案是硬编码英文，因此这里
采用 **资源覆盖** 的方式汉化，不改动任何 Swift 源码：

- 汉化只做在构建产物里：CI 在打包 `.ipa` 前把 `zh-Hans.lproj` 复制进
  `Payload/vreader.app/`，并把 `CFBundleLocalizations` 补成 `en, zh-Hans`。
- `Localizable.strings` 的键就是源码里 SwiftUI 的中英文字面量
  （`Text("Cancel")` 的键即 `Cancel`），所以只要键一致，运行时就会命中中文。

## 覆盖范围

| 类别 | 状态 |
|---|---|
| 静态界面文案（按钮、对话框、设置项、空状态、导航标题） | ✅ 已汉化 |
| 模型/服务层里的错误提示、排序名、范围名（约 100 条，需改源码包 `String(localized:)`） | ⏳ 第二批 |
| 用户数据（书名、作者、服务商名、文件名） | 保持原样（不应翻译） |
| 系统格式化（日期、数字、百分比） | 跟随设备语言，由 iOS 提供 |
| 品牌/技术标识（`ChatGPT`、`WebDAV`、`UTF-8`、`EN`、`Aa`） | 保留原文 |

## 如何在设备上生效

1. 系统语言是简体中文时自动生效。
2. 系统语言不是中文时，进入 **设置 → vreader → 语言** 选择「简体中文」
   （若该入口未出现，请把系统语言切换为简体中文）。
3. 应用内没有语言切换入口 —— 上游没有该设置项，汉化也没有新增。

## 如何重新出包

在 fork 的 Actions 里运行 *Build unsigned IPA*（默认参数即可）。构建脚本会
`plutil -lint` 校验 `Localizable.strings`，并在日志里打印实际注入的键数量。

## 维护

改翻译后直接改 `zh-Hans.lproj/Localizable.strings` 再重新构建即可，不需要动
Xcode 工程。新增文案时，键必须与源码字面量完全一致（注意 `\u{2026}` 这类
Swift 转义要写成解码后的真实字符，例如 `…`）。
