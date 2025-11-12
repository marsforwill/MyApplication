import { router } from '@kit.ArkUI';
import { TarotCard, drawRandomCard } from '../models/TarotCard';
import { CardPlaceholder } from '../components/CardPlaceholder';

/**
 * 首页组件
 * 展示塔罗牌背面，点击后随机抽取一张牌
 */
@Entry
@Component
struct Index {
  // 当前抽中的卡牌，null表示还未抽牌
  @State currentCard: TarotCard | null = null;
  // 是否显示卡牌正面（用于翻牌动画）
  @State isCardFlipped: boolean = false;
  // 是否显示卡牌信息（用于淡入动画）
  @State showCardInfo: boolean = false;
  // 卡牌旋转角度（用于翻牌动画）
  @State cardRotation: number = 0;

  /**
   * 抽牌函数
   * 随机选择一张卡牌并更新状态
   */
  drawCard() {
    // 重置状态，准备新的抽牌动画
    this.isCardFlipped = false;
    this.showCardInfo = false;
    this.cardRotation = 0;

    // 延迟执行，让重置动画先完成
    setTimeout(() => {
      // 随机抽取一张卡牌
      this.currentCard = drawRandomCard();

      // 开始翻牌动画
      this.isCardFlipped = true;
      this.cardRotation = 180;

      // 延迟显示卡牌信息，实现淡入效果
      setTimeout(() => {
        this.showCardInfo = true;
      }, 300);
    }, 200);
  }

  build() {
    Column() {
      // 应用标题
      Text($r('app.string.app_title'))
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ top: 60, bottom: 40 })
        .opacity(0.95)

      // 卡牌容器
      Stack() {
        // 卡牌背面（未抽牌时显示）
        if (!this.isCardFlipped) {
          Image($r('app.media.card_back'))
            .width(200)
            .height(320)
            .borderRadius(16)
            .shadow({
              radius: 20,
              color: $r('app.color.card_shadow'),
              offsetX: 0,
              offsetY: 10
            })
            .transition(TransitionEffect.OPACITY.animation({ duration: 300, curve: Curve.EaseInOut }))
        }

        // 卡牌正面（抽牌后显示）
        if (this.isCardFlipped && this.currentCard) {
          Image(this.currentCard.image)
            .width(200)
            .height(320)
            .borderRadius(16)
            .shadow({
              radius: 20,
              color: $r('app.color.card_shadow'),
              offsetX: 0,
              offsetY: 10
            })
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, curve: Curve.EaseInOut }))
        }
      }
      .width(200)
      .height(320)
      .onClick(() => {
        // 如果还未抽牌，点击卡牌背面进行抽牌
        if (!this.isCardFlipped) {
          this.drawCard();
        }
      })

      // 卡牌信息区域（抽牌后显示）
      if (this.showCardInfo && this.currentCard) {
        Column() {
          // 卡牌名称
          Text(this.currentCard.name)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 30, bottom: 12 })
            .opacity(this.showCardInfo ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, curve: Curve.EaseInOut }))

          // 卡牌含义简述
          Text(this.currentCard.description)
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .textAlign(TextAlign.Center)
            .padding({ left: 30, right: 30 })
            .lineHeight(24)
            .opacity(this.showCardInfo ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 200, curve: Curve.EaseInOut }))

          // 查看详情按钮
          Button($r('app.string.view_details'))
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.button_primary'))
            .fontColor(Color.White)
            .fontSize(16)
            .margin({ top: 20 })
            .borderRadius(20)
            .width(140)
            .height(40)
            .onClick(() => {
              // 跳转到结果页，传递卡牌ID
              router.pushUrl({
                url: 'pages/ResultPage',
                params: {
                  cardId: this.currentCard?.id
                }
              });
            })
            .opacity(this.showCardInfo ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 400, curve: Curve.EaseInOut }))
        }
        .width('100%')
        .transition(TransitionEffect.OPACITY.animation({ duration: 500, curve: Curve.EaseInOut }))
      }

      // 重新抽牌按钮（抽牌后显示）
      if (this.showCardInfo) {
        Button($r('app.string.draw_again'))
          .type(ButtonType.Normal)
          .backgroundColor($r('app.color.button_secondary'))
          .fontColor($r('app.color.text_primary'))
          .fontSize(16)
          .margin({ top: 30 })
          .borderRadius(20)
          .width(140)
          .height(40)
          .onClick(() => {
            this.drawCard();
          })
          .opacity(this.showCardInfo ? 1 : 0)
          .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 600, curve: Curve.EaseInOut }))
      }

      // 提示文字（未抽牌时显示）
      if (!this.isCardFlipped) {
        Text($r('app.string.tap_to_draw'))
          .fontSize(14)
          .fontColor($r('app.color.text_hint'))
          .margin({ top: 30 })
          .opacity(0.7)
          .transition(TransitionEffect.OPACITY.animation({ duration: 300, curve: Curve.EaseInOut }))
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_primary'))
    .justifyContent(FlexAlign.Start)
    .padding({ left: 20, right: 20 })
  }
}
