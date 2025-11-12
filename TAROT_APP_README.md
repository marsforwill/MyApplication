Image($rawfile('images/' + dynamicName + '.png'))
// 目录示例：entry/src/main/resources/rawfile/images/# 塔罗牌占卜应用 - 开发说明

## 项目概述

这是一个基于 HarmonyOS NEXT 和 ArkTS 开发的塔罗牌占卜应用 MVP。应用采用 Stage 模型，使用声明式 UI 框架 ArkUI 构建。

## 技术栈

- **开发语言**：ArkTS（基于 TypeScript）
- **应用模型**：Stage 模型
- **UI 框架**：ArkUI（声明式 UI）
- **SDK 版本**：HarmonyOS 6.0.0 (API 20)
- **构建工具**：Hvigor

## 项目结构

```
entry/src/main/
├── ets/
│   ├── entryability/
│   │   └── EntryAbility.ets          # 应用入口 Ability
│   ├── models/
│   │   └── TarotCard.ets             # 塔罗牌数据模型
│   └── pages/
│       ├── Index.ets                 # 首页（抽牌页面）
│       └── ResultPage.ets            # 结果页（详情页面）
└── resources/
    └── base/
        ├── element/
        │   ├── color.json            # 颜色资源
        │   └── string.json           # 字符串资源
        ├── media/                    # 图片资源目录
        └── profile/
            └── main_pages.json       # 页面路由配置
```

## 核心功能

### 1. 首页（Index.ets）

- **功能**：
  - 输入占卜问题并选择牌阵（单张 / 三张 / 七张）
  - 点击“开始占卜”后自动抽取对应数量的卡牌
  - 展示抽牌结果摘要（问题、卡牌、位置说明）
  - 提供“查看详情”跳转结果页，以及“重新占卜”功能

- **状态管理**：
  - `@State userQuestion`: 当前输入的问题
  - `@State selectedSpread`: 选中的牌阵类型（`SpreadType` 枚举）
  - `@State hasStartedReading`: 是否已经生成占卜结果
  - `@State readingResult`: 本次占卜的完整结果（含卡牌、解读）
  - `@State showCardInfo`: 控制结果信息淡入显示

- **动画效果**：
  - 组件淡入淡出展示
  - 查看详情 / 重新占卜按钮分阶段显现

### 2. 结果页（ResultPage.ets）

- **功能**：
  - 展示完整的占卜问题、牌阵、牌位标签以及详细解读
  - 支持三种牌阵布局：单张、三张（过去/现在/未来）、七张（完整展开）
  - 在新逻辑下通过 `readingResult` 路由参数渲染，兼容旧版的 `cardId`

- **路由参数**：
  - `readingResult`：包含问题、牌阵类型、卡牌数组、文本解读
  - 兼容 `cardId`：若旧版调用仅传 ID，则页面回退至单卡牌展示

### 3. 数据模型（TarotCard.ets）

- **数据结构**：
  ```typescript
  interface TarotCard {
    id: number;
    name: string;
    image: Resource;
    description: string;
    fullDescription: string;
  }
  ```

- **卡牌数据**：
  - 包含22张大阿卡纳牌
  - 每张牌包含ID、名称、图片资源、简要描述和详细描述

- **随机抽牌**：
  - `drawMultipleCards()` 保证多次抽牌不重复
  - 通过 `SpreadType` 区分单张、三张、七张牌阵

- **占卜结果模型**：
  - `ReadingResult`：统一封装问题、牌阵类型、抽到的牌、文本解读
  - `DrawnCard`：描述单张牌及其在牌阵中的位置/含义标签
  - `generate*Reading()`：针对不同牌阵生成 `ReadingResult`
  - 解读函数会根据用户问题关键词给出个性化前言，并逐条拼接牌位分析

## UI 设计

### 颜色方案

- **背景色**：深紫色 `#1A0D2E`（神秘氛围）
- **主文本色**：淡紫色 `#E8D5FF`
- **次文本色**：中紫色 `#C4A8E8`
- **提示文本**：深紫色 `#9B7DB8`
- **按钮主色**：紫色 `#6B46C1`
- **按钮次色**：亮紫色 `#8B5CF6`

### 动画效果

1. **翻牌动画**：使用 `TransitionEffect.OPACITY` 实现淡入淡出
2. **文字渐显**：通过 `opacity` 和 `transition` 实现延迟显示
3. **按钮动画**：分阶段显示，增强视觉层次

## 资源文件

### 图片资源

需要在 `entry/src/main/resources/base/media/` 目录下添加以下图片：

- `card_back.png` - 卡牌背面（必需）
- `card_00.png` 到 `card_21.png` - 22张大阿卡纳牌（必需）

详细说明请参考 `entry/src/main/resources/base/media/README.md`

### 字符串资源

所有文本内容已配置在 `string.json` 中，支持国际化扩展。

- 新增项：
  - 问题输入提示文案、牌阵选项、错误提示等

### 颜色资源

所有颜色值已配置在 `color.json` 中，便于主题切换。

## 运行说明

### 前置条件

1. 安装 DevEco Studio（支持 HarmonyOS NEXT）
2. 配置 HarmonyOS SDK 6.0.0
3. 准备真机或模拟器

### 运行步骤

1. **添加图片资源**：
   - 将塔罗牌图片放置在 `entry/src/main/resources/base/media/` 目录
   - 确保文件名与代码中的资源引用一致

2. **构建项目**：
   ```bash
   # 在项目根目录执行
   hvigorw assembleHap
   ```

3. **运行应用**：
   - 在 DevEco Studio 中点击运行按钮
   - 或使用 Preview 模式预览（部分功能可能受限）

4. **体验占卜流程**：
   - 输入问题 → 选择牌阵 → 点击“开始占卜”
   - 首页即可查看抽牌结果摘要，点击“查看详情”跳转至结果页查看完整解读

### Preview 模式

应用支持 DevEco Studio 的 Preview 模式，但需要注意：

- 路由跳转功能在 Preview 中可能受限
- 建议使用真机或模拟器测试完整功能

## 代码特点

### 1. 符合 HarmonyOS 规范

- 使用 Stage 模型
- 遵循 ArkUI 声明式 UI 规范
- 使用官方推荐的资源管理方式

### 2. 状态管理

- 使用 `@State` 装饰器管理组件状态
- 状态变化自动触发 UI 更新

### 3. 路由导航

- 使用 `router.pushUrl` 进行页面跳转
- 结果页支持 `readingResult`（完整对象）与 `cardId`（兼容旧版）两种参数

### 4. 动画实现

- 使用 `TransitionEffect` 实现过渡动画
- 通过淡入延迟控制组件出现时机

## 扩展建议

1. **添加更多卡牌**：扩展小阿卡纳牌（56张）
2. **卡牌正逆位**：支持正位和逆位解读
3. **占卜记录**：保存历史抽牌记录
4. **分享功能**：分享抽中的卡牌
5. **主题切换**：支持多种颜色主题
6. **音效**：添加翻牌音效和背景音乐

## 注意事项

1. **图片资源**：必须添加所有必需的图片文件，否则应用无法正常运行
2. **路由参数**：Resource 类型无法直接传递，改为传递 ID 后查找
3. **动画性能**：大量动画可能影响性能，注意优化
4. **资源大小**：图片文件不宜过大，建议压缩优化

## 技术支持

如有问题，请参考：
- [HarmonyOS 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/)
- [ArkUI 开发指南](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkui-overview)

## 许可证

本项目为示例项目，仅供学习参考。

