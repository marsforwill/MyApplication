/**
 * 卡牌占位符组件
 * 当图片资源不存在时，使用代码生成的占位符
 */
@Component
export struct CardPlaceholder {
  // 卡牌名称（用于显示在占位符上）
  cardName?: string = '';
  // 是否为背面
  isBack: boolean = false;
  // 宽度
  private widthValue: number | string = 200;
  // 高度
  private heightValue: number | string = 320;

  build() {
    Stack() {
      // 使用 Canvas 绘制占位符
      if (this.isBack) {
        // 卡牌背面占位符
        Column() {
          Text('🃏')
            .fontSize(80)
            .fontColor($r('app.color.text_primary'))
            .opacity(0.6)
          Text('塔罗牌')
            .fontSize(20)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10 })
            .opacity(0.8)
        }
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.button_primary'))
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
      } else {
        // 卡牌正面占位符
        Column() {
          // 装饰性符号
          Text('✨')
            .fontSize(50)
            .fontColor($r('app.color.text_primary'))
            .opacity(0.7)
            .margin({ bottom: 15 })

          // 卡牌名称
          if (this.cardName) {
            Text(this.cardName)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .textAlign(TextAlign.Center)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .padding({ left: 10, right: 10 })
          }

          // 装饰性边框
          Row() {
            Text('━━━━━━')
              .fontSize(12)
              .fontColor($r('app.color.text_secondary'))
              .opacity(0.5)
          }
          .margin({ top: 15 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.button_secondary'))
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .border({
          width: 2,
          color: $r('app.color.divider'),
          style: BorderStyle.Solid
        })
      }
    }
    .width(this.widthValue)
    .height(this.heightValue)
    .shadow({
      radius: 20,
      color: $r('app.color.card_shadow'),
      offsetX: 0,
      offsetY: 10
    })
  }

  // width属性方法
  width(value: number | string): CardPlaceholder {
    this.widthValue = value;
    return this;
  }

  // height属性方法
  height(value: number | string): CardPlaceholder {
    this.heightValue = value;
    return this;
  }
}

