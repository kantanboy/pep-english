/**
 * PEP小学英语 - 首页
 * 人教PEP版 三年级起点
 */
import router from '@ohos.router';

// 年级信息
interface GradeInfo {
  grade: number;
  name: string;
  icon: string;
  desc: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State stars: number = 0;
  @State wordCount: number = 0;
  @State learnDays: number = 1;
  @State checkinStreak: number = 0;
  @State isCheckedIn: boolean = false;
  @State mascotEmoji: string = '🦊';
  @State mascotText: string = '嗨！我是小狐狸，跟我一起学英语吧！';

  // 年级数据
  grades: GradeInfo[] = [
    { grade: 3, name: '三年级', icon: '3️⃣', desc: '上下册 · 12单元', color: '#FF6B6B' },
    { grade: 4, name: '四年级', icon: '4️⃣', desc: '上下册 · 12单元', color: '#4ECDC4' },
    { grade: 5, name: '五年级', icon: '5️⃣', desc: '上下册 · 12单元', color: '#A78BFA' },
    { grade: 6, name: '六年级', icon: '6️⃣', desc: '上下册 · 12单元', color: '#FB923C' },
  ];

  aboutToAppear(): void {
    this.loadData();
  }

  loadData(): void {
    // TODO: 从首选项或数据库加载数据
    this.stars = 0;
    this.wordCount = 0;
    this.learnDays = 1;
    this.checkinStreak = 0;
    this.isCheckedIn = false;
  }

  doCheckin(): void {
    if (this.isCheckedIn) return;
    this.isCheckedIn = true;
    this.checkinStreak += 1;
    this.stars += 1 + Math.min(this.checkinStreak - 1, 4);
    this.mascotSay('📅', `签到成功！连续${this.checkinStreak}天！`);
  }

  goGrade(g: number): void {
    router.pushUrl({
      url: 'pages/Units',
      params: { grade: g }
    });
  }

  mascotSay(emoji: string, text: string): void {
    this.mascotEmoji = emoji;
    this.mascotText = text;
  }

  build() {
    Column() {
      // 顶部栏
      Row() {
        Text('PEP小学英语')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        Row() {
          Text('⭐').fontSize(16)
          Text(this.stars.toString()).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#FF6B6B')
        }
      }
      .width('100%')
      .padding({ top: 12, bottom: 10, left: 16, right: 16 })

      Scroll() {
        Column({ space: 14 }) {
          // 英雄区
          Column({ space: 4 }) {
            Text('🦊')
              .fontSize(56)
              .textAlign(TextAlign.Center)
              .width('100%')
            Text('PEP小学英语')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF6B6B')
              .width('100%')
              .textAlign(TextAlign.Center)
            Text('三年级起点 · 小狐狸陪你学英语')
              .fontSize(12)
              .fontColor('#718096')
              .width('100%')
              .textAlign(TextAlign.Center)
          }
          .width('100%')

          // 统计
          Row({ space: 8 }) {
            this.StatCard(this.stars.toString(), '收集星星', '#FB923C')
            this.StatCard(this.wordCount.toString(), '已学单词', '#4ECDC4')
            this.StatCard(this.learnDays.toString(), '学习天数', '#60A5FA')
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          // 打卡
          Row() {
            Text('📅').fontSize(24)
            Column({ space: 2 }) {
              Text('每日打卡').fontSize(13).fontWeight(FontWeight.Bold).fontColor(Color.White)
              Text(this.isCheckedIn ? '今日已签到' : '点击签到领奖励')
                .fontSize(10)
                .fontColor('rgba(255,255,255,0.85)')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: 10 })
            Text(this.isCheckedIn ? `🔥${this.checkinStreak}` : '')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.isCheckedIn ? '#4ECDC4' : '#FB923C')
          .borderRadius(14)
          .padding({ left: 16, right: 16 })
          .onClick(() => this.doCheckin())

          // 选择年级
          Text('📚 选择年级')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16 })

          Grid({ columns: 2, gutter: 10 }) {
            ForEach(this.grades, (g: GradeInfo) => {
              GridItem() {
                Column({ space: 6 }) {
                  Text(g.icon).fontSize(32)
                  Text(g.name).fontSize(15).fontWeight(FontWeight.Bold).fontColor(g.color)
                  Text(g.desc).fontSize(11).fontColor('#718096')
                }
                .width('100%')
                .padding({ top: 16, bottom: 14 })
                .backgroundColor('#FFF')
                .borderRadius(16)
                .onClick(() => this.goGrade(g.grade))
              }
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
        }
      }
      .layoutWeight(1)
      .width('100%')

      // 底部小狐狸
      Row() {
        Text(this.mascotEmoji).fontSize(32)
        Row() {
          Text(this.mascotText).fontSize(12).fontColor('#2D3748')
        }
        .layoutWeight(1)
        .padding({ left: 8, right: 8 })
        .margin({ left: 6 })
        .backgroundColor('rgba(255,249,196,0.9)')
        .borderRadius(12)
        .padding(6)
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor('rgba(255,255,255,0.92)')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  StatCard(num: string, lbl: string, color: string) {
    Column({ space: 2 }) {
      Text(num).fontSize(20).fontWeight(FontWeight.Bold).fontColor(color)
      Text(lbl).fontSize(10).fontColor('#718096')
    }
    .layoutWeight(1)
    .padding({ top: 8, bottom: 6 })
    .backgroundColor(Color.White)
    .borderRadius(14)
  }
}
