import { BaZiUtils } from '../utils/BaZiUtils';
import router from '@ohos.router';

@Entry
@Component
struct BaZiPage {
  @State selectedDate: Date = new Date();
  @State result: string[] = ['', '', '', ''];
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
                  Column() {
                    Text('年柱')
                      .fontSize(14)
                      .fontColor(Color.Gray)
                    Text(this.result[0])
                      .fontSize(24)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 5 })
                  }
                }

                GridItem() {
                  Column() {
                    Text('月柱')
                      .fontSize(14)
                      .fontColor(Color.Gray)
                    Text(this.result[1])
                      .fontSize(24)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 5 })
                  }
                }

                GridItem() {
                  Column() {
                    Text('日柱')
                      .fontSize(14)
                      .fontColor(Color.Gray)
                    Text(this.result[2])
                      .fontSize(24)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 5 })
                  }
                }

                GridItem() {
                  Column() {
                    Text('时柱')
                      .fontSize(14)
                      .fontColor(Color.Gray)
                    Text(this.result[3])
                      .fontSize(24)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 5 })
                  }
                }
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .width('100%')
              .height(100)
              .backgroundColor('#FFF8E1')
              .borderRadius(10)
              .padding(10)
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
}
