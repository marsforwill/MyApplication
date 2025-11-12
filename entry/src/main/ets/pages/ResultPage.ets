import { router } from '@kit.ArkUI';
import { TarotCard, TAROT_CARDS, ReadingResult, SpreadType, DrawnCard } from '../models/TarotCard';

/**
 * 结果页组件
 * 展示占卜结果的详细信息，包括多张牌和个性化解读
 */
interface ResultPageParams {
  readingResult?: ReadingResult;
  cardId?: number;
}

@Entry
@Component
struct ResultPage {
  @State readingResult: ReadingResult | null = null;
  @State card: TarotCard | null = null;
  @State showContent: boolean = false;

  /**
   * 页面显示时触发动画
   */
  aboutToAppear() {
    const params = router.getParams() as ResultPageParams | undefined;

    if (params && params.readingResult) {
      this.readingResult = params.readingResult;
    } else if (params && params.cardId !== undefined) {
      const cardId = params.cardId;
      this.card = TAROT_CARDS.find(item => item.id === cardId) || null;
    }

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
    Scroll() {
      Column() {
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

        if (this.readingResult) {
          this.buildReadingResult(this.readingResult)
        } else if (this.card) {
          this.buildSingleCardLegacy(this.card)
        } else {
          this.buildErrorView()
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_primary'))
  }

  /**
   * 构建占卜结果视图（新版本）
   */
  @Builder
  buildReadingResult(reading: ReadingResult) {
    Column() {
      this.buildQuestionSection(reading.question)

      if (reading.spreadType === SpreadType.SINGLE && reading.cards.length >= 1) {
        this.buildSingleCardSection(reading.cards[0])
      } else if (reading.spreadType === SpreadType.THREE && reading.cards.length >= 3) {
        this.buildThreeCardSection(reading.cards)
      } else if (reading.spreadType === SpreadType.SEVEN && reading.cards.length >= 7) {
        this.buildSevenCardSection(reading.cards)
      }

      Divider()
        .color($r('app.color.divider'))
        .strokeWidth(1)
        .margin({ top: 30, left: 40, right: 40, bottom: 20 })
        .opacity(this.showContent ? 1 : 0)
        .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 300, curve: Curve.EaseInOut }))

      this.buildInterpretationSection(reading.interpretation)

      Button($r('app.string.back_to_home'))
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.button_primary'))
        .fontColor(Color.White)
        .fontSize(16)
        .margin({ top: 30 })
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
  }

  /**
   * 问题信息展示
   */
  @Builder
  buildQuestionSection(question: string) {
    Column() {
      Text($r('app.string.your_question'))
        .fontSize(14)
        .fontColor($r('app.color.text_hint'))
        .margin({ bottom: 8 })
      Text(question)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_primary'))
        .textAlign(TextAlign.Center)
        .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .padding({ top: 20, bottom: 20 })
    .backgroundColor($r('app.color.background_secondary'))
    .borderRadius(12)
    .margin({ bottom: 30 })
    .opacity(this.showContent ? 1 : 0)
    .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))
  }

  /**
   * 构建单张牌视图
   */
  @Builder
  buildSingleCardSection(card: DrawnCard) {
    Column() {
      Image(card.card.image)
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
        .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))

      if (this.showContent) {
        Text(card.card.name)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 20, bottom: 12 })
        Text(card.card.description)
          .fontSize(16)
          .fontColor($r('app.color.text_secondary'))
          .textAlign(TextAlign.Center)
          .padding({ left: 30, right: 30 })
          .lineHeight(24)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 构建三张牌视图
   */
  @Builder
  buildThreeCardSection(cards: DrawnCard[]) {
    Row() {
      this.buildThreeCardItem(cards[0])
      this.buildThreeCardItem(cards[1])
      this.buildThreeCardItem(cards[2])
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildThreeCardItem(card: DrawnCard) {
    Column() {
      Image(card.card.image)
        .width(110)
        .height(176)
        .borderRadius(12)
        .opacity(this.showContent ? 1 : 0)
        .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))

      if (this.showContent) {
        Text(card.positionLabel || '')
          .fontSize(12)
          .fontColor($r('app.color.text_hint'))
          .margin({ top: 8 })
        Text(card.card.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 4 })
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }
    .width(110)
    .margin({ left: 8, right: 8 })
  }

  /**
   * 构建七张牌布局
   */
  @Builder
  buildSevenCardSection(cards: DrawnCard[]) {
    Column() {
      Row() {
        this.buildSevenCardItem(cards[0])
        this.buildSevenCardItem(cards[1])
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 16 })

      Row() {
        this.buildSevenCardItem(cards[2])
        this.buildSevenCardItem(cards[3])
        this.buildSevenCardItem(cards[4])
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 16 })

      Row() {
        this.buildSevenCardItem(cards[5])
        this.buildSevenCardItem(cards[6])
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
  }

  @Builder
  buildSevenCardItem(card: DrawnCard) {
    Column() {
      Image(card.card.image)
        .width(96)
        .height(154)
        .borderRadius(10)
        .opacity(this.showContent ? 1 : 0)
        .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))

      if (this.showContent) {
        Text(card.positionLabel || '')
          .fontSize(10)
          .fontColor($r('app.color.text_hint'))
          .margin({ top: 6 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(card.card.name)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 4 })
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }
    .width(96)
  }

  /**
   * 构建解读区域
   */
  @Builder
  buildInterpretationSection(content: string) {
    Column() {
      Text('占卜解读')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Start)

      Text(content)
        .fontSize(16)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(28)
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding({ top: 20, bottom: 20, left: 20, right: 20 })
    .backgroundColor($r('app.color.background_secondary'))
    .borderRadius(12)
    .opacity(this.showContent ? 1 : 0)
    .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 400, curve: Curve.EaseInOut }))
  }

  /**
   * 构建单张卡牌视图（兼容旧版本）
   */
  @Builder
  buildSingleCardLegacy(card: TarotCard) {
    Column() {
      Image(card.image)
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

      Text(card.name)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ top: 30, bottom: 20 })
        .opacity(this.showContent ? 1 : 0)
        .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 200, curve: Curve.EaseInOut }))

      Divider()
        .color($r('app.color.divider'))
        .strokeWidth(1)
        .margin({ left: 40, right: 40, bottom: 20 })
        .opacity(this.showContent ? 1 : 0)
        .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 300, curve: Curve.EaseInOut }))

      Text(card.fullDescription)
        .fontSize(16)
        .fontColor($r('app.color.text_secondary'))
        .textAlign(TextAlign.Center)
        .lineHeight(28)
        .padding({ left: 30, right: 30 })
        .opacity(this.showContent ? 1 : 0)
        .transition(TransitionEffect.OPACITY.animation({ duration: 500, delay: 400, curve: Curve.EaseInOut }))

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
  }

  /**
   * 构建错误视图
   */
  @Builder
  buildErrorView() {
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

