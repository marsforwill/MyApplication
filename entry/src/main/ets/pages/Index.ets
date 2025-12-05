import { router } from '@kit.ArkUI';
import {
  SpreadType,
  ReadingResult,
  DrawnCard,
  drawMultipleCards,
  generateSingleCardReading,
  generateThreeCardReading,
  generateSevenCardReading,
  TAROT_CARDS,
  TarotCard
} from '../models/TarotCard';

/**
 * 首页组件
 * 展示问题输入、牌阵选择，然后进行占卜
 */
@Entry
@Component
struct Index {
  // 用户输入的问题
  @State userQuestion: string = '';
  // 选择的牌阵类型
  @State selectedSpread: SpreadType | null = null;
  // 是否已开始占卜（显示抽牌结果）
  @State hasStartedReading: boolean = false;
  // 占卜结果
  @State readingResult: ReadingResult | null = null;
  // 是否显示卡牌信息（用于淡入动画）
  @State showCardInfo: boolean = false;
  @State flippedCardIds: number[] = [];

  // 每日运势相关
  @StorageLink('dailyCardDate') dailyCardDate: string = '';
  @StorageLink('dailyCardId') dailyCardId: number = -1;
  @State dailyCard: TarotCard | null = null;

  aboutToAppear() {
    this.checkDailyCard();
  }

  checkDailyCard() {
    const today = new Date().toDateString();
    if (this.dailyCardDate === today && this.dailyCardId !== -1) {
      // 今天已经抽过牌
      this.dailyCard = TAROT_CARDS.find(card => card.id === this.dailyCardId) || null;
    } else {
      // 新的一天，重置
      if (this.dailyCardDate !== today) {
        this.dailyCardDate = '';
        this.dailyCardId = -1;
        this.dailyCard = null;
      }
    }
  }

  drawDailyCard() {
    // 随机抽取一张牌
    const randomIndex = Math.floor(Math.random() * TAROT_CARDS.length);
    const card = TAROT_CARDS[randomIndex];
    
    // 保存结果
    this.dailyCardId = card.id;
    this.dailyCardDate = new Date().toDateString();
    this.dailyCard = card;
  }

  /**
   * 开始占卜
   */
  startReading() {
    // 验证输入
    if (!this.userQuestion.trim()) {
      // 可以添加提示
      return;
    }
    if (!this.selectedSpread) {
      // 可以添加提示
      return;
    }

    // 重置状态
    this.hasStartedReading = true;
    this.showCardInfo = false;
    this.flippedCardIds = [];

    // 根据牌阵类型抽取卡牌
    let result: ReadingResult;
    const cards = drawMultipleCards(this.selectedSpread!);

    if (this.selectedSpread === SpreadType.SINGLE) {
      result = generateSingleCardReading(this.userQuestion, cards[0]);
    } else if (this.selectedSpread === SpreadType.THREE) {
      result = generateThreeCardReading(this.userQuestion, cards);
    } else {
      result = generateSevenCardReading(this.userQuestion, cards);
    }

    this.readingResult = result;

    // 延迟显示卡牌信息，实现淡入效果
    setTimeout(() => {
      this.showCardInfo = true;
    }, 300);
  }

  /**
   * 重新开始占卜
   */
  resetReading() {
    this.hasStartedReading = false;
    this.readingResult = null;
    this.showCardInfo = false;
    this.flippedCardIds = [];
    // 保留问题和牌阵选择
  }

  handleCardFlip(cardId: number) {
    if (this.flippedCardIds.includes(cardId)) {
      return;
    }
    this.flippedCardIds = [...this.flippedCardIds, cardId];
  }

  isCardFlipped(cardId: number): boolean {
    return this.flippedCardIds.includes(cardId);
  }

  build() {
    Stack() {
      // 背景图片 - 使用 Image 组件确保正确显示
      Image($r('app.media.background'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .alt($r('app.media.background'))

      // 内容层
      Scroll() {
        Column() {
          // 应用标题
          Text($r('app.string.app_title'))
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 40, bottom: 30 })
            .opacity(0.95)

          // 每日运势卡片
          if (!this.hasStartedReading) {
            this.buildDailyTarotSection()
          }

          if (!this.hasStartedReading) {
            // 问题输入和牌阵选择界面
            this.buildQuestionInput()
          } else if (this.readingResult) {
            // 占卜结果界面
            this.buildReadingResult(this.readingResult)
          }
        }
        .width('100%')
        .padding({ left: 20, right: 20, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  /**
   * 构建问题输入和牌阵选择界面
   */
  @Builder
  buildQuestionInput() {
    Column() {
      // 问题输入区域
      Column() {
        Text($r('app.string.enter_question'))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .margin({ bottom: 12 })
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({ placeholder: $r('app.string.question_placeholder') })
          .width('100%')
          .height(50)
          .backgroundColor($r('app.color.background_secondary'))
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onChange((value: string) => {
            this.userQuestion = value;
          })
      }
      .width('100%')
      .margin({ bottom: 30 })

      // 牌阵选择区域
      Column() {
        Text($r('app.string.select_spread'))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .margin({ bottom: 16 })
          .width('100%')
          .textAlign(TextAlign.Start)

        // 单张牌选项
        Row() {
          Text($r('app.string.spread_single'))
            .fontSize(16)
            .fontColor(this.selectedSpread === SpreadType.SINGLE ? Color.White : $r('app.color.text_primary'))
        }
        .width('100%')
        .height(50)
        .backgroundColor(this.selectedSpread === SpreadType.SINGLE ? $r('app.color.button_primary') :
          $r('app.color.background_secondary'))
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })
        .onClick(() => {
          this.selectedSpread = SpreadType.SINGLE;
        })

        // 三张牌选项
        Row() {
          Text($r('app.string.spread_three'))
            .fontSize(16)
            .fontColor(this.selectedSpread === SpreadType.THREE ? Color.White : $r('app.color.text_primary'))
        }
        .width('100%')
        .height(50)
        .backgroundColor(this.selectedSpread === SpreadType.THREE ? $r('app.color.button_primary') :
          $r('app.color.background_secondary'))
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })
        .onClick(() => {
          this.selectedSpread = SpreadType.THREE;
        })

        // 七张牌选项
        Row() {
          Text($r('app.string.spread_seven'))
            .fontSize(16)
            .fontColor(this.selectedSpread === SpreadType.SEVEN ? Color.White : $r('app.color.text_primary'))
        }
        .width('100%')
        .height(50)
        .backgroundColor(this.selectedSpread === SpreadType.SEVEN ? $r('app.color.button_primary') :
          $r('app.color.background_secondary'))
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedSpread = SpreadType.SEVEN;
        })
      }
      .width('100%')
      .margin({ bottom: 30 })

      // 查看所有塔罗牌按钮
      Button($r('app.string.goto_card_library'))
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.button_secondary'))
        .fontColor($r('app.color.text_primary'))
        .fontSize(14)
        .width('100%')
        .height(44)
        .borderRadius(22)
        .margin({ top: 4, bottom: 8 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/CardLibrary'
          });
        })

      // 八字分析按钮
      Button('八字分析')
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.button_secondary'))
        .fontColor($r('app.color.text_primary'))
        .fontSize(14)
        .width('100%')
        .height(44)
        .borderRadius(22)
        .margin({ bottom: 8 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/BaZiPage'
          });
        })

      // 开始占卜按钮
      Button($r('app.string.start_reading'))
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.button_primary'))
        .fontColor(Color.White)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .height(50)
        .borderRadius(25)
        .enabled(this.userQuestion.trim().length > 0 && this.selectedSpread !== null)
        .opacity((this.userQuestion.trim().length > 0 && this.selectedSpread !== null) ? 1 : 0.5)
        .onClick(() => {
          this.startReading();
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  /**
   * 构建占卜结果界面
   */
  @Builder
  buildReadingResult(reading: ReadingResult) {
    Column() {
      this.buildQuestionSummary(reading.question)

      if (reading.spreadType === SpreadType.SINGLE && reading.cards.length >= 1) {
        this.buildSingleCardSection(reading.cards[0])
      } else if (reading.spreadType === SpreadType.THREE && reading.cards.length >= 3) {
        this.buildThreeCardSection(reading.cards)
      } else if (reading.spreadType === SpreadType.SEVEN && reading.cards.length >= 7) {
        this.buildSevenCardSection(reading.cards)
      }

      if (this.showCardInfo) {
        Column() {
          Button($r('app.string.view_details'))
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.button_primary'))
            .fontColor(Color.White)
            .fontSize(16)
            .margin({ top: 30 })
            .borderRadius(20)
            .width(160)
            .height(44)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ResultPage',
                params: {
                  readingResult: reading
                }
              });
            })
            .opacity(1)

          Button($r('app.string.draw_again'))
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.button_secondary'))
            .fontColor($r('app.color.text_primary'))
            .fontSize(16)
            .margin({ top: 20 })
            .borderRadius(20)
            .width(160)
            .height(44)
            .onClick(() => {
              this.resetReading();
            })
            .opacity(1)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))
      }
    }
    .width('100%')
  }

  /**
   * 显示用户问题摘要
   */
  @Builder
  buildQuestionSummary(question: string) {
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
    .opacity(this.showCardInfo ? 1 : 0)
    .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))
  }

  /**
   * 构建单张牌显示
   */
  @Builder
  buildSingleCardSection(card: DrawnCard) {
    Column() {
      this.buildFlipCard(card, 220, 350, 18, true, this.isCardFlipped(card.card.id))

      if (this.showCardInfo && this.isCardFlipped(card.card.id)) {
        Text(card.card.name)
          .fontSize(24)
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
   * 构建七张牌显示
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
    .margin({ bottom: 20 })
  }

  @Builder
  buildThreeCardItem(card: DrawnCard) {
    Column() {
      this.buildFlipCard(card, 100, 160, 12, false, this.isCardFlipped(card.card.id))

      if (this.showCardInfo && this.isCardFlipped(card.card.id)) {
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
    .width(100)
    .margin({ left: 4, right: 4 })
  }

  /**
   * 构建七张牌显示
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
      .margin({ bottom: 12 })

      Row() {
        this.buildSevenCardItem(cards[2])
        this.buildSevenCardItem(cards[3])
        this.buildSevenCardItem(cards[4])
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 12 })

      Row() {
        this.buildSevenCardItem(cards[5])
        this.buildSevenCardItem(cards[6])
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .margin({ bottom: 20 })
  }

  /**
   * 构建单张卡牌项（用于七张牌布局）
   */
  @Builder
  buildSevenCardItem(card: DrawnCard) {
    Column() {
      this.buildFlipCard(card, 96, 154, 10, false, this.isCardFlipped(card.card.id))

      if (this.showCardInfo && this.isCardFlipped(card.card.id)) {
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

  @Builder
  buildFlipCard(card: DrawnCard, width: number, height: number, borderRadius: number = 12, showShadow: boolean = false,
    flipped: boolean = false) {
    Stack() {
      Image($r('app.media.card_back'))
        .width(width)
        .height(height)
        .borderRadius(borderRadius)
        .opacity((this.showCardInfo ? 1 : 0) * (flipped ? 0 : 1))
        .rotate({ x: 0, y: 1, z: 0, angle: flipped ? 180 : 0 })
        .animation({ duration: 280, curve: Curve.EaseInOut })

      Image(card.card.image)
        .width(width)
        .height(height)
        .borderRadius(borderRadius)
        .opacity((this.showCardInfo ? 1 : 0) * (flipped ? 1 : 0))
        .rotate({ x: 0, y: 1, z: 0, angle: flipped ? 0 : -180 })
        .animation({ duration: 280, curve: Curve.EaseInOut })
    }
    .width(width)
    .height(height)
    .borderRadius(borderRadius)
    .shadow(showShadow ? {
      radius: 25,
      color: $r('app.color.card_shadow'),
      offsetX: 0,
      offsetY: 15
    } : {
      radius: 0,
      color: Color.Transparent,
      offsetX: 0,
      offsetY: 0
    })
    .scale({ x: flipped ? 1 : 0.96, y: flipped ? 1 : 0.96, z: 1 })
    .opacity(this.showCardInfo ? 1 : 0)
    .transition(TransitionEffect.OPACITY.animation({ duration: 400, curve: Curve.EaseInOut }))
    .onClick(() => {
      if (!this.showCardInfo || flipped) {
        return;
      }
      animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
        this.handleCardFlip(card.card.id);
      })
    })
  }

  /**
   * 构建每日运势区域
   */
  @Builder
  buildDailyTarotSection() {
    Column() {
      Text('每日运势')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Start)

      if (this.dailyCard) {
        // 已抽牌展示
        Row() {
          Image(this.dailyCard.image)
            .width(60)
            .height(96)
            .borderRadius(8)
            .margin({ right: 16 })

          Column() {
            Text('今日指引：' + this.dailyCard.name)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor($r('app.color.text_primary'))
              .margin({ bottom: 8 })
            
            Text(this.dailyCard.description)
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          
          // 跳转详情箭头
          Text('>')
            .fontSize(20)
            .fontColor($r('app.color.text_hint'))
            .margin({ left: 8 })
        }
        .width('100%')
        .padding(16)
        .backgroundColor($r('app.color.background_secondary'))
        .borderRadius(16)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ResultPage',
            params: {
              cardId: this.dailyCard?.id
            }
          });
        })
      } else {
        // 未抽牌展示
        Button('抽取今日运势牌')
          .type(ButtonType.Normal)
          .backgroundColor($r('app.color.button_secondary')) // 使用次级按钮颜色以区别于开始占卜
          .fontColor($r('app.color.text_primary'))
          .fontSize(16)
          .width('100%')
          .height(60)
          .borderRadius(16)
          .onClick(() => {
            this.drawDailyCard();
          })
      }
    }
    .width('100%')
    .margin({ bottom: 30 })
  }
}
