import { router } from '@kit.ArkUI';
import { vibrator } from '@kit.SensorServiceKit';
import { LotteryStick, getLevelText, getLevelColor } from '../models/LotteryStick';

/**
 * 签文详情页
 * 展示完整的解签内容
 */
@Entry
@Component
struct LotteryDetailPage {
  @State stick: LotteryStick | null = null;
  @State userQuestion: string = '';

  aboutToAppear() {
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.stick = params['stick'] as LotteryStick;
      this.userQuestion = params['question'] as string || '';
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('←')
          .fontSize(24)
          .fontColor($r('app.color.text_primary'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            try {
              vibrator.startVibration({
                type: 'time',
                duration: 30
              }, {
                usage: 'touch'
              });
            } catch (error) {
              console.error('Vibration error:', error);
            }
            router.back();
          })

        Text('📜 签文详解')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .margin({ left: 12 })
      }
      .width('100%')
      .padding({ top: 20, left: 20, right: 20, bottom: 10 })

      if (this.stick) {
        Scroll() {
          Column() {
            // 用户问题
            if (this.userQuestion) {
              Column() {
                Text('您的问题')
                  .fontSize(14)
                  .fontColor($r('app.color.text_hint'))
                  .margin({ bottom: 8 })
                  .width('100%')

                Text(this.userQuestion)
                  .fontSize(16)
                  .fontColor($r('app.color.text_primary'))
                  .width('100%')
              }
              .width('100%')
              .padding(16)
              .backgroundColor($r('app.color.background_secondary'))
              .borderRadius(12)
              .margin({ bottom: 20 })
            }

            // 签号和等级
            Text(this.stick.name + ' · ' + getLevelText(this.stick.level))
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(getLevelColor(this.stick.level))
              .margin({ bottom: 20 })
              .textAlign(TextAlign.Center)
              .width('100%')

            // 签文诗句
            Column() {
              Text('签文')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.text_secondary'))
                .margin({ bottom: 12 })
                .width('100%')

              Text(this.stick.poem)
                .fontSize(18)
                .fontColor($r('app.color.text_primary'))
                .lineHeight(32)
                .textAlign(TextAlign.Center)
                .width('100%')
                .fontFamily('serif')
            }
            .width('100%')
            .padding(20)
            .backgroundColor($r('app.color.background_secondary'))
            .borderRadius(12)
            .margin({ bottom: 20 })

            // 总体含义
            this.buildSection('总体含义', this.stick.meaning)

            // 详细解签
            this.buildSection('详细解签', this.stick.detail)

            // 分类运势
            Column() {
              Text('分类运势')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 16 })
                .width('100%')

              // 姻缘运势
              this.buildFortuneItem('💕 姻缘运势', this.stick.love)

              // 事业运势
              this.buildFortuneItem('💼 事业运势', this.stick.career)

              // 财运
              this.buildFortuneItem('💰 财运', this.stick.wealth)

              // 健康运势
              this.buildFortuneItem('🏥 健康运势', this.stick.health)
            }
            .width('100%')
            .padding(20)
            .backgroundColor($r('app.color.background_secondary'))
            .borderRadius(12)
            .margin({ bottom: 20 })

            // 温馨提示
            Column() {
              Text('📌 温馨提示')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })
                .width('100%')

              Text('签文仅供参考，命运掌握在自己手中。保持积极心态，努力奋斗，方能创造美好未来。')
                .fontSize(14)
                .fontColor($r('app.color.text_hint'))
                .lineHeight(22)
                .width('100%')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('rgba(255, 193, 7, 0.1)')
            .borderRadius(12)
            .margin({ bottom: 20 })

            // 返回按钮
            Button('返回首页')
              .type(ButtonType.Normal)
              .backgroundColor($r('app.color.button_primary'))
              .fontColor(Color.White)
              .fontSize(16)
              .width('100%')
              .height(50)
              .borderRadius(25)
              .margin({ top: 10, bottom: 20 })
              .onClick(() => {
                router.back();
              })
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 40 })
        }
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_primary'))
  }

  /**
   * 构建内容区块
   */
  @Builder
  buildSection(title: string, content: string) {
    Column() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ bottom: 12 })
        .width('100%')

      Text(content)
        .fontSize(15)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(26)
        .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor($r('app.color.background_secondary'))
    .borderRadius(12)
    .margin({ bottom: 20 })
  }

  /**
   * 构建运势条目
   */
  @Builder
  buildFortuneItem(title: string, content: string) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_primary'))
        .margin({ bottom: 8 })
        .width('100%')

      Text(content)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(24)
        .width('100%')
    }
    .width('100%')
    .margin({ bottom: 16 })
  }
}
