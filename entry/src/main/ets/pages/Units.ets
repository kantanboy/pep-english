/**
 * PEP小学英语 - 单元列表页
 */
import router from '@ohos.router';

interface UnitInfo {
  name: string;
  theme: string;
  wordCount: number;
  index: number;
}

@Entry
@Component
struct Units {
  @State grade: number = 3;
  @State bookIndex: number = 0;
  @State units: UnitInfo[] = [];

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, number>;
    this.grade = params?.grade ?? 3;
    this.loadUnits();
  }

  loadUnits(): void {
    // TODO: 加载单元数据
    this.units = [
      { name: 'Unit 1 Making friends', theme: '交朋友', wordCount: 18, index: 0 },
      { name: 'Unit 2 Different families', theme: '家庭', wordCount: 16, index: 1 },
      { name: 'Unit 3 Our animal friends', theme: '动物', wordCount: 16, index: 2 },
      { name: 'Unit 4 Plants around us', theme: '植物', wordCount: 16, index: 3 },
      { name: 'Unit 5 The colourful world', theme: '颜色', wordCount: 16, index: 4 },
      { name: 'Unit 6 Useful numbers', theme: '数字', wordCount: 16, index: 5 },
    ];
  }

  goUnit(unitIndex: number): void {
    router.pushUrl({
      url: 'pages/Learn',
      params: { grade: this.grade, unit: unitIndex }
    });
  }

  build() {
    Column() {
      // 顶部栏
      Row() {
        Text(`${this.grade}年级`)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 12, bottom: 10, left: 16, right: 16 })

      // 学期选择
      Row({ space: 8 }) {
        Text('上册').padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor(this.bookIndex === 0 ? '#4ECDC4' : '#FFF')
          .fontColor(this.bookIndex === 0 ? '#FFF' : '#718096')
          .borderRadius(12)
          .onClick(() => { this.bookIndex = 0; this.loadUnits(); })
        Text('下册').padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor(this.bookIndex === 1 ? '#4ECDC4' : '#FFF')
          .fontColor(this.bookIndex === 1 ? '#FFF' : '#718096')
          .borderRadius(12)
          .onClick(() => { this.bookIndex = 1; this.loadUnits(); })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 10 })

      Scroll() {
        Column({ space: 8 }) {
          ForEach(this.units, (u: UnitInfo) => {
            Row() {
              Text(`${u.index + 1}`).fontSize(24).fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center).width(36)
              Column({ space: 2 }) {
                Text(u.name).fontSize(14).fontWeight(FontWeight.Bold)
                Text(`${u.theme} · ${u.wordCount}词`).fontSize(11).fontColor('#718096')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 10 })
              Text('›').fontSize(16).fontColor('#718096')
            }
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(14)
            .onClick(() => this.goUnit(u.index))
          })
        }
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
