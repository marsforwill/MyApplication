import { BaZiUtils, BaZiResult } from '../utils/BaZiUtils';
import router from '@ohos.router';

@Entry
@Component
struct BaZiPage {
  @State selectedDate: Date = new Date();
  @State result: BaZiResult | null = null;
  @State analyzed: boolean = false;

  build() {
    Column() {
      // Header
      Row() {
        Text('八字分析')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F1F3F5')

      Scroll() {
        Column() {
          Text('请输入您的出生日期和时间')
            .fontSize(16)
            .margin({ top: 20, bottom: 10 })

          // Date Picker
          DatePicker({
            start: new Date('1900-01-01'),
            end: new Date('2100-12-31'),
            selected: this.selectedDate,
          })
            .onChange((value: DatePickerResult) => {
              this.selectedDate.setFullYear(value.year ?? 2000, value.month ?? 0, value.day ?? 1)
            })
            .height(150)

          // Time Picker
          TimePicker({
            selected: this.selectedDate,
          })
            .onChange((value: TimePickerResult) => {
              this.selectedDate.setHours(value.hour ?? 0, value.minute ?? 0)
            })
            .height(150)
            .margin({ top: 10 })

          Button('开始分析')
            .width('80%')
            .height(50)
            .margin({ top: 30 })
            .onClick(() => {
              this.result = BaZiUtils.analyze(this.selectedDate);
              this.analyzed = true;
            })

          if (this.analyzed) {
            Column() {
              Text('您的八字排盘结果：')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 30, bottom: 20 })

              Grid() {
                GridItem() {
                  this.buildPillar('年柱', this.result!.pillars[0])
                }

                GridItem() {
                  this.buildPillar('月柱', this.result!.pillars[1])
                }

                GridItem() {
                  this.buildPillar('日柱', this.result!.pillars[2])
                }

                GridItem() {
                  this.buildPillar('时柱', this.result!.pillars[3])
                }
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .width('100%')
              .height(120)
              .backgroundColor('#FFF8E1')
              .borderRadius(10)
              .padding(10)

              // Five Elements Summary
              Column() {
                Text('五行统计')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 20, bottom: 10 })
                  .width('100%')
                
                Flex({ wrap: FlexWrap.Wrap }) {
                  this.buildElementCount('金', this.result!.elementCounts.get('金') || 0)
                  this.buildElementCount('木', this.result!.elementCounts.get('木') || 0)
                  this.buildElementCount('水', this.result!.elementCounts.get('水') || 0)
                  this.buildElementCount('火', this.result!.elementCounts.get('火') || 0)
                  this.buildElementCount('土', this.result!.elementCounts.get('土') || 0)
                }
              }
              .width('100%')

              // Analysis
              Column() {
                Text('日元分析')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 20, bottom: 10 })
                  .width('100%')
                
                Text(this.result!.dayMasterAnalysis)
                  .fontSize(14)
                  .lineHeight(20)
                  .backgroundColor('#F0F0F0')
                  .padding(10)
                  .borderRadius(8)
                  .width('100%')
              }
              .width('100%')

              // Zodiac and Lucky Info
              Column() {
                Text('趣味运势')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 20, bottom: 10 })
                  .width('100%')
                
                Row() {
                  Column() {
                    Text('星座')
                      .fontSize(12)
                      .fontColor(Color.Gray)
                    Text(this.result!.zodiac)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 4 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Center)
                  .backgroundColor('#F0F0F0')
                  .padding(10)
                  .borderRadius(8)
                  .margin({ right: 8 })

                  Column() {
                    Text('幸运色')
                      .fontSize(12)
                      .fontColor(Color.Gray)
                    Text(this.result!.luckyColor)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(this.getLuckyColorValue(this.result!.luckyColor))
                      .margin({ top: 4 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Center)
                  .backgroundColor('#F0F0F0')
                  .padding(10)
                  .borderRadius(8)
                  .margin({ right: 8 })

                  Column() {
                    Text('幸运数字')
                      .fontSize(12)
                      .fontColor(Color.Gray)
                    Text(this.result!.luckyNumber.toString())
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 4 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Center)
                  .backgroundColor('#F0F0F0')
                  .padding(10)
                  .borderRadius(8)
                }
                .width('100%')
              }
              .width('100%')
            }
            .width('100%')
            .padding(16)
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildPillar(title: string, pillar: string) {
    Column() {
      Text(title)
        .fontSize(14)
        .fontColor(Color.Gray)
      
      Row() {
        Column() {
          Text(pillar.charAt(0))
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
          Text(BaZiUtils.getElement(pillar.charAt(0)))
            .fontSize(10)
            .fontColor(this.getElementColor(BaZiUtils.getElement(pillar.charAt(0))))
        }
        .margin({ right: 4 })

        Column() {
          Text(pillar.charAt(1))
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
          Text(BaZiUtils.getElement(pillar.charAt(1)))
            .fontSize(10)
            .fontColor(this.getElementColor(BaZiUtils.getElement(pillar.charAt(1))))
        }
      }
      .margin({ top: 5 })
    }
  }

  @Builder
  buildElementCount(element: string, count: number) {
    Row() {
      Text(element + ': ')
        .fontSize(14)
        .fontColor(this.getElementColor(element))
      Text(count.toString())
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
    }
    .margin({ right: 16, bottom: 8 })
    .padding({ top: 4, bottom: 4, left: 8, right: 8 })
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E0E0E0' })
  }

  getElementColor(element: string): string {
    switch (element) {
      case '金': return '#FFD700'; // Gold
      case '木': return '#228B22'; // Forest Green
      case '水': return '#1E90FF'; // Dodger Blue
      case '火': return '#FF4500'; // Orange Red
      case '土': return '#8B4513'; // Saddle Brown
      default: return '#000000';
    }
  }

  getLuckyColorValue(colorName: string): string {
    switch (colorName) {
      case '红色': return '#FF0000';
      case '橙色': return '#FFA500';
      case '黄色': return '#FFD700';
      case '绿色': return '#008000';
      case '青色': return '#00FFFF';
      case '蓝色': return '#0000FF';
      case '紫色': return '#800080';
      case '粉色': return '#FFC0CB';
      case '白色': return '#000000'; // Use black for text visibility on white bg, or gray
      case '金色': return '#FFD700';
      default: return '#000000';
    }
  }
}
