import { router } from '@kit.ArkUI';
import {
  LotteryStick,
  drawLotteryStick,
  getLevelText,
  getLevelColor
} from '../models/LotteryStick';

/**
 * 抽签页面
 * 提供摇签动画和抽签结果展示
 */
@Entry
@Component
struct LotteryPage {
  @State isShaking: boolean = false;          // 是否正在摇签
  @State hasDrawn: boolean = false;            // 是否已经抽签
  @State drawnStick: LotteryStick | null = null; // 抽中的签
  @State showResult: boolean = false;          // 是否显示结果
  @State userQuestion: string = '';            // 用户问题
  @State shakeAngle: number = 0;               // 摇动角度
  @State tubeScale: number = 1;                // 签筒缩放
  @State stickOffset: number = 0;              // 签条偏移
  @State showStick: boolean = false;           // 是否显示签条
  private shakeTimer: number = -1;

  aboutToDisappear() {
    if (this.shakeTimer !== -1) {
      clearInterval(this.shakeTimer);
    }
  }

  /**
   * 开始摇签
   */
  startShaking() {
    if (this.isShaking || this.hasDrawn) {
      return;
    }

    this.isShaking = true;
    this.hasDrawn = false;
    this.showResult = false;
    this.showStick = false;
    this.stickOffset = 0;

    // 摇动动画 - 增强效果
    let count = 0;
    this.shakeTimer = setInterval(() => {
      // 随机角度和幅度，模拟真实摇动
      const intensity = 1 - (count / 30); // 逐渐减弱
      this.shakeAngle = (Math.random() - 0.5) * 40 * intensity; // -20到20度
      this.tubeScale = 1 + (Math.random() - 0.5) * 0.1 * intensity; // 轻微缩放
      
      count++;

      if (count >= 30) { // 摇动3秒后停止
        clearInterval(this.shakeTimer);
        this.showStickAnimation();
      }
    }, 100);
  }

  /**
   * 显示签条弹出动画
   */
  showStickAnimation() {
    this.shakeAngle = 0;
    this.tubeScale = 1;
    this.showStick = true;
    
    // 签条从签筒中弹出
    let offset = 0;
    const popTimer = setInterval(() => {
      offset += 5;
      this.stickOffset = offset;
      
      if (offset >= 50) { // 弹出50px
        clearInterval(popTimer);
        setTimeout(() => {
          this.completeShaking();
        }, 800);
      }
    }, 30);
  }

  /**
   * 完成摇签，显示结果
   */
  completeShaking() {
    this.shakeAngle = 0;
    this.isShaking = false;
    
    // 抽取签文
    this.drawnStick = drawLotteryStick();
    this.hasDrawn = true;

    // 延迟显示结果，增加悬念
    setTimeout(() => {
      this.showResult = true;
    }, 500);
  }

  /**
   * 查看详细解签
   */
  viewDetail() {
    if (!this.drawnStick) return;

    router.pushUrl({
      url: 'pages/LotteryDetailPage',
      params: {
        stick: this.drawnStick,
        question: this.userQuestion
      }
    });
  }

  /**
   * 重新抽签
   */
  resetDraw() {
    this.hasDrawn = false;
    this.showResult = false;
    this.drawnStick = null;
    this.shakeAngle = 0;
    this.tubeScale = 1;
    this.stickOffset = 0;
    this.showStick = false;
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
            router.back();
          })

        Text('观音灵签')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .margin({ left: 12 })
      }
      .width('100%')
      .padding({ top: 20, left: 20, right: 20, bottom: 10 })

      Scroll() {
        Column() {
          // 说明文字
          if (!this.hasDrawn) {
            Text('诚心诚意，心诚则灵')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 20, bottom: 10 })
              .opacity(0.8)

            // 问题输入
            Column() {
              Text('请输入您的问题（可选）')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .margin({ bottom: 8 })
                .width('100%')
                .textAlign(TextAlign.Start)

              TextInput({ placeholder: '例如：事业发展、感情运势等' })
                .width('100%')
                .height(50)
                .backgroundColor($r('app.color.background_secondary'))
                .borderRadius(12)
                .padding({ left: 16, right: 16 })
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
                .onChange((value: string) => {
                  this.userQuestion = value;
                })
            }
            .width('90%')
            .margin({ top: 10, bottom: 30 })
          }

          // 签筒区域
          Column() {
            if (!this.hasDrawn) {
              // 摇签动画区域
              Column() {
                // 签筒容器
                Stack({ alignContent: Alignment.Top }) {
                  // 签筒主体
                  Column() {
                    // 签筒口部
                    Column()
                      .width(100)
                      .height(15)
                      .backgroundColor('rgba(139, 92, 246, 0.3)')
                      .borderRadius({ topLeft: 8, topRight: 8 })
                      .border({
                        width: 2,
                        color: 'rgba(139, 92, 246, 0.5)'
                      })
                    
                    // 签筒身
                    Column() {
                      Text('🎋')
                        .fontSize(100)
                    }
                    .width(120)
                    .height(180)
                    .backgroundColor('rgba(139, 92, 246, 0.15)')
                    .borderRadius(12)
                    .border({
                      width: 2,
                      color: 'rgba(139, 92, 246, 0.4)'
                    })
                    .justifyContent(FlexAlign.Center)
                    
                    Text('观音灵签')
                      .fontSize(14)
                      .fontColor($r('app.color.text_secondary'))
                      .margin({ top: 8 })
                      .fontWeight(FontWeight.Medium)
                  }
                  .rotate({ angle: this.shakeAngle })
                  .scale({ x: this.tubeScale, y: this.tubeScale })
                  .animation({
                    duration: 100,
                    curve: Curve.Friction
                  })

                  // 弹出的签条
                  if (this.showStick) {
                    Column() {
                      Text('📜')
                        .fontSize(40)
                        .rotate({ angle: -15 })
                    }
                    .offset({ y: -this.stickOffset })
                    .opacity(this.showStick ? 1 : 0)
                    .animation({
                      duration: 300,
                      curve: Curve.EaseOut
                    })
                  }
                }
                .width(200)
                .height(250)
              }
              .margin({ top: 20, bottom: 40 })

              // 摇签提示
              Text(this.isShaking ? '正在摇签...' : '点击下方按钮开始摇签')
                .fontSize(16)
                .fontColor($r('app.color.text_secondary'))
                .margin({ bottom: 30 })
                .opacity(this.isShaking ? 1 : 0.6)

              // 开始摇签按钮
              Button(this.isShaking ? '摇签中...' : '🙏 开始摇签')
                .type(ButtonType.Normal)
                .backgroundColor(this.isShaking ? $r('app.color.button_secondary') : $r('app.color.button_primary'))
                .fontColor(Color.White)
                .fontSize(18)
                .width('80%')
                .height(50)
                .borderRadius(25)
                .enabled(!this.isShaking)
                .onClick(() => {
                  this.startShaking();
                })
            } else {
              // 抽签结果显示
              this.buildResult()
            }
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding({ left: 20, right: 20, bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_primary'))
  }

  /**
   * 构建抽签结果展示
   */
  @Builder
  buildResult() {
    Column() {
      // 签文卡片
      Column() {
        // 签号和等级
        Text(this.drawnStick!.name + ' · ' + getLevelText(this.drawnStick!.level))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(getLevelColor(this.drawnStick!.level))
          .margin({ bottom: 20 })

        // 签文诗句
        Text(this.drawnStick!.poem)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .lineHeight(28)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 20 })
          .fontFamily('serif')

        // 签文含义
        Text(this.drawnStick!.meaning)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .textAlign(TextAlign.Center)
          .margin({ bottom: 10 })
      }
      .width('90%')
      .padding(24)
      .backgroundColor($r('app.color.background_secondary'))
      .borderRadius(16)
      .shadow({
        radius: 20,
        color: 'rgba(0,0,0,0.1)',
        offsetX: 0,
        offsetY: 4
      })
      .opacity(this.showResult ? 1 : 0)
      .animation({
        duration: 500,
        curve: Curve.EaseOut
      })

      // 操作按钮
      if (this.showResult) {
        Row() {
          Button('查看详解')
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.button_primary'))
            .fontColor(Color.White)
            .fontSize(16)
            .height(48)
            .layoutWeight(1)
            .borderRadius(24)
            .margin({ right: 10 })
            .onClick(() => {
              this.viewDetail();
            })

          Button('重新抽签')
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.background_secondary'))
            .fontColor($r('app.color.text_primary'))
            .fontSize(16)
            .height(48)
            .layoutWeight(1)
            .borderRadius(24)
            .margin({ left: 10 })
            .onClick(() => {
              this.resetDraw();
            })
        }
        .width('90%')
        .margin({ top: 30 })
        .opacity(this.showResult ? 1 : 0)
        .animation({
          duration: 500,
          delay: 300,
          curve: Curve.EaseOut
        })
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}
