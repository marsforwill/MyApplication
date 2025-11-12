# 塔罗牌占卜应用 - 快速开始指南

## ✅ 好消息：应用现在可以直接运行！

**应用已内置代码生成的占位符，无需添加图片资源即可立即运行和测试！**

占位符会自动显示：
- 卡牌背面：紫色背景 + 🃏 图标 + "塔罗牌"文字
- 卡牌正面：亮紫色背景 + ✨ 图标 + 卡牌名称

---

## 可选：添加真实图片资源

如果你想使用真实的塔罗牌图片，可以将图片放置在：

```
entry/src/main/resources/base/media/
```

### 图片列表（可选）

1. **card_back.png** - 塔罗牌背面（1张）
2. **card_00.png** 到 **card_21.png** - 22张大阿卡纳牌

### 如何添加真实图片

#### 方法1：使用在线资源

1. 访问公开的塔罗牌图片库（注意版权）
2. 下载22张大阿卡纳牌图片
3. 重命名为 card_00.png 到 card_21.png
4. 下载或创建一张卡牌背面图片 card_back.png
5. 将图片放置在 `entry/src/main/resources/base/media/` 目录

#### 方法2：使用AI生成

使用AI工具（如Midjourney、DALL-E等）生成塔罗牌风格的图片。

### 图片规格

- **格式**：PNG 或 JPG
- **尺寸**：建议 400x640px（宽高比 5:8）
- **文件大小**：每张不超过 500KB

## 第一步：验证项目结构

确保项目结构如下：

```
entry/src/main/
├── ets/
│   ├── entryability/
│   │   └── EntryAbility.ets          ✅
│   ├── components/
│   │   └── CardPlaceholder.ets       ✅ (占位符组件)
│   ├── models/
│   │   └── TarotCard.ets             ✅
│   └── pages/
│       ├── Index.ets                 ✅
│       └── ResultPage.ets            ✅
└── resources/
    └── base/
        ├── element/
        │   ├── color.json            ✅
        │   └── string.json           ✅
        ├── media/                    ✅ (可选，已有占位符)
        └── profile/
            └── main_pages.json       ✅
```

## 第二步：运行应用（无需添加图片！）

### 在 DevEco Studio 中运行

1. **打开项目**
   - 使用 DevEco Studio 打开项目根目录

2. **同步项目**
   - 点击 "Sync Project" 同步依赖

3. **运行应用**
   - 连接真机或启动模拟器
   - 点击运行按钮（绿色三角形）
   - 或使用快捷键 `Shift + F10`

### 使用 Preview 模式

1. 打开 `entry/src/main/ets/pages/Index.ets`
2. 点击右上角的 Preview 按钮
3. 注意：Preview 模式中路由跳转可能受限

### 使用命令行构建

```bash
# 在项目根目录执行
hvigorw assembleHap
```

## 第三步：测试功能

### 测试流程

1. **启动应用**
   - 应用应显示深紫色背景
   - 显示"今日塔罗占卜"标题
   - 显示卡牌背面和提示文字

2. **抽牌测试**
   - 点击卡牌背面
   - 应该看到卡牌翻转动画
   - 显示随机卡牌、名称和描述

3. **查看详情**
   - 点击"查看详情"按钮
   - 应该跳转到结果页
   - 显示卡牌完整信息

4. **重新抽牌**
   - 返回首页
   - 点击"重新抽牌"按钮
   - 应该重新随机抽取卡牌

## 常见问题

### Q1: 应用启动后显示空白或报错

**原因**：可能是代码编译错误

**解决**：
- 检查 DevEco Studio 的错误提示
- 重新同步项目（Sync Project）
- 清理并重新构建项目

### Q2: 看到占位符而不是真实图片

**原因**：这是正常的！应用使用代码生成的占位符

**解决**：
- 这是预期行为，应用可以正常使用
- 如果想使用真实图片，请参考"可选：添加真实图片资源"部分
- 占位符不影响应用功能，所有功能都可以正常使用

### Q3: 路由跳转不工作

**原因**：Preview模式限制或路由配置问题

**解决**：
- 使用真机或模拟器测试（不使用Preview）
- 检查 `main_pages.json` 中是否包含 ResultPage
- 检查路由路径是否正确

### Q4: 动画不流畅

**原因**：设备性能或动画配置问题

**解决**：
- 在真机上测试（模拟器可能性能较差）
- 检查是否有其他应用占用资源

## 下一步

应用运行成功后，你可以：

1. **添加真实图片**：将塔罗牌图片添加到 `media/` 目录，然后修改代码使用 `Image` 组件替代占位符
2. **自定义UI**：修改 `color.json` 中的颜色值，或调整 `CardPlaceholder.ets` 中的占位符样式
3. **添加更多卡牌**：在 `TarotCard.ets` 中添加小阿卡纳牌
4. **优化动画**：调整动画时长和效果
5. **添加功能**：实现占卜记录、分享等功能

### 如何将占位符替换为真实图片

如果你想使用真实图片，需要：

1. 将图片文件添加到 `entry/src/main/resources/base/media/` 目录
2. 修改 `Index.ets` 和 `ResultPage.ets`，将 `CardPlaceholder` 替换为 `Image` 组件
3. 使用 `$r('app.media.card_xx')` 引用图片资源

示例代码：
```typescript
// 替换占位符为真实图片
Image($r('app.media.card_back'))
  .width(200)
  .height(320)
  .borderRadius(16)
```

## 技术支持

- 查看详细文档：`TAROT_APP_README.md`
- 图片资源说明：`entry/src/main/resources/base/media/README.md`
- HarmonyOS官方文档：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/

