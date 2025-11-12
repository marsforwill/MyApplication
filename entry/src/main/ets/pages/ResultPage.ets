import { router } from '@kit.ArkUI';
import { TarotCard, TAROT_CARDS } from '../models/TarotCard';
import { CardPlaceholder } from '../components/CardPlaceholder';

/**
 * 结果页组件
 * 展示抽中的塔罗牌详细信息
 */
@Entry
@Component
struct ResultPage {
  // 从路由参数中获取卡牌数据
  @State card: TarotCard | null = null;
  // 控制页面元素淡入动画
  @State showContent: boolean = false;

  /**
   * 页面显示时触发动画
   */
  aboutToAppear() {
    // 从路由参数中获取传递的卡牌ID
    const params = router.getParams() as Record<string, number>;
    if (params && params['cardId'] !== undefined) {
      const cardId = params['cardId'];
      // 根据ID查找对应的卡牌
      this.card = TAROT_CARDS.find(card => card.id === cardId) || null;
    }

    // 延迟显示内容，实现淡入效果
    setTimeout(() => {
      this.showContent = true;
    }, 100);
  }

  /**
   * 返回首页
   */
  goBack() {
    router.back();
  }

  build() {
    Column() {
      // 返回按钮
      Row() {
        Text('←')
          .fontSize(20)
          .fontColor($r('app.color.text_primary'))
          .fontWeight(FontWeight.Bold)
        Text($r('app.string.back_to_home'))
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .margin({ left: 8 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .padding({ top: 20, left: 20, bottom: 20 })
      .onClick(() => {
        this.goBack();
      })
      .opacity(this.showContent ? 1 : 0)
      .transition(TransitionEffect.OPACITY.animation({ duration: 300, curve: Curve.EaseInOut }))

      if (this.card) {
        Column() {
          // 卡牌图片（使用真实图片）
          Image(this.card.image)
            .width(220)
            .height(350)
            .borderRadius(18)
            .shadow({
              radius: 25,
              color: $r('app.color.card_shadow'),
              offsetX: 0,
              offsetY: 15
            })
            .opacity(this.showContent ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, curve: Curve.EaseInOut }))

          // 卡牌名称
          Text(this.card.name)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 30, bottom: 20 })
            .opacity(this.showContent ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 200, curve: Curve.EaseInOut }))

          // 分隔线
          Divider()
            .color($r('app.color.divider'))
            .strokeWidth(1)
            .margin({ left: 40, right: 40, bottom: 20 })
            .opacity(this.showContent ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 300, curve: Curve.EaseInOut }))

          // 卡牌详细描述
          Text(this.card.fullDescription)
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .textAlign(TextAlign.Center)
            .lineHeight(28)
            .padding({ left: 30, right: 30 })
            .opacity(this.showContent ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 400, curve: Curve.EaseInOut }))

          // 返回首页按钮
          Button($r('app.string.back_to_home'))
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.button_primary'))
            .fontColor(Color.White)
            .fontSize(16)
            .margin({ top: 40 })
            .borderRadius(20)
            .width(160)
            .height(44)
            .onClick(() => {
              this.goBack();
            })
            .opacity(this.showContent ? 1 : 0)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 600, curve: Curve.EaseInOut }))
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      } else {
        // 如果没有卡牌数据，显示错误提示
        Column() {
          Text($r('app.string.no_card_data'))
            .fontSize(18)
            .fontColor($r('app.color.text_secondary'))
            .margin({ bottom: 20 })

          Button($r('app.string.back_to_home'))
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.button_primary'))
            .fontColor(Color.White)
            .onClick(() => {
              this.goBack();
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_primary'))
    .padding({ bottom: 40 })
  }
}

