import { router } from '@kit.ArkUI';
import { vibrator } from '@kit.SensorServiceKit';
import { TarotCard, TAROT_CARDS } from '../models/TarotCard';

@Entry
@Component
struct CardLibrary {
  @State searchText: string = '';
  @State cardList: TarotCard[] = TAROT_CARDS;

  updateFilter() {
    const keyword = this.searchText.trim();
    if (!keyword) {
      this.cardList = TAROT_CARDS;
      return;
    }
    this.cardList = TAROT_CARDS.filter(card => {
      return card.name.includes(keyword) || card.description.includes(keyword);
    });
  }

  build() {
    Column() {
      // 顶部返回与标题
      Row() {
        Text('←')
          .fontSize(20)
          .fontColor($r('app.color.text_primary'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.back();
          })

        Text($r('app.string.card_library_title'))
          .fontSize(18)
          .fontColor($r('app.color.text_primary'))
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ top: 20, left: 20, right: 20, bottom: 10 })

      // 搜索框
      TextInput({ placeholder: $r('app.string.card_library_search_placeholder') })
        .width('100%')
        .height(40)
        .backgroundColor($r('app.color.background_secondary'))
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .fontSize(14)
        .fontColor($r('app.color.text_primary'))
        .margin({ left: 20, right: 20, bottom: 10 })
        .onChange((value: string) => {
          this.searchText = value;
          this.updateFilter();
        })

      // 说明文字
      Text($r('app.string.card_library_subtitle'))
        .fontSize(12)
        .fontColor($r('app.color.text_hint'))
        .margin({ left: 20, right: 20, bottom: 10 })

      // 列表区域
      Scroll() {
        Column() {
          if (this.cardList.length === 0) {
            Text($r('app.string.card_library_empty'))
              .fontSize(14)
              .fontColor($r('app.color.text_hint'))
              .margin({ top: 40, bottom: 20 })
              .textAlign(TextAlign.Center)
          } else {
            ForEach(this.cardList, (card: TarotCard) => {
              this.buildCardItem(card);
            }, (card: TarotCard) => card.id.toString())
          }
        }
        .width('100%')
        .padding({ left: 20, right: 20, bottom: 30 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_primary'))
  }

  @Builder
  buildCardItem(card: TarotCard) {
    Row() {
      Image(card.image)
        .width(60)
        .height(96)
        .borderRadius(8)

      Column() {
        Text(card.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .margin({ bottom: 4 })

        Text(card.description)
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .margin({ left: 12 })

      Blank()

      Text('>')
        .fontSize(20)
        .fontColor($r('app.color.text_hint'))
        .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor($r('app.color.background_secondary'))
    .borderRadius(12)
    .margin({ bottom: 12 })
    .shadow({
      radius: 8,
      color: 'rgba(0,0,0,0.06)',
      offsetX: 0,
      offsetY: 2
    })
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
      router.pushUrl({
        url: 'pages/ResultPage',
        params: {
          cardId: card.id
        }
      });
    })
  }
}


