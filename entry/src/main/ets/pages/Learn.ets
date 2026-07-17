/**
 * PEP小学英语 - 学习页
 * 包含单词、句型、游戏三个Tab
 */
import router from '@ohos.router';

// 单词数据
interface Word {
  w: string;
  e: string;
  c: string;
  p: string;
}

// 句型数据
interface Sentence {
  q: string;
  qc: string;
  a: string;
  ac: string;
}

@Entry
@Component
struct Learn {
  @State grade: number = 3;
  @State unit: number = 0;
  @State tab: string = 'words';
  @State words: Word[] = [];
  @State sents: Sentence[] = [];

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, number>;
    this.grade = params?.grade ?? 3;
    this.unit = params?.unit ?? 0;
    this.loadData();
  }

  loadData(): void {
    // TODO: 加载实际数据
    this.words = [
      { w: 'name', e: '🏷️', c: '名字', p: '/neɪm/' },
      { w: 'nice', e: '😊', c: '友好的', p: '/naɪs/' },
      { w: 'ear', e: '👂', c: '耳朵', p: '/ɪə/' },
      { w: 'hand', e: '✋', c: '手', p: '/hænd/' },
      { w: 'eye', e: '👁️', c: '眼睛', p: '/aɪ/' },
      { w: 'mouth', e: '👄', c: '嘴', p: '/maʊθ/' },
    ];
    this.sents = [
      { q: 'Hello, my name is Mike.', qc: '你好，我叫迈克。', a: 'Hi! Nice to meet you.', ac: '嗨！很高兴认识你。' },
      { q: 'How are you?', qc: '你好吗？', a: "I'm fine, thank you!", ac: '我很好，谢谢！' },
    ];
  }

  speak(text: string): void {
    // TODO: 调用 TTS 发音
    console.log('speak:', text);
  }

  build() {
    Column() {
      // 顶部栏
      Row() {
        Text(`Unit ${this.unit + 1}`)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 12, bottom: 10, left: 16, right: 16 })

      // Tab 选择
      Row({ space: 8 }) {
        Text('📖 单词').padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor(this.tab === 'words' ? '#4ECDC4' : '#FFF')
          .fontColor(this.tab === 'words' ? '#FFF' : '#718096')
          .borderRadius(12)
          .onClick(() => this.tab = 'words')
        Text('💬 句型').padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor(this.tab === 'sents' ? '#4ECDC4' : '#FFF')
          .fontColor(this.tab === 'sents' ? '#FFF' : '#718096')
          .borderRadius(12)
          .onClick(() => this.tab = 'sents')
        Text('🎮 游戏').padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor(this.tab === 'game' ? '#4ECDC4' : '#FFF')
          .fontColor(this.tab === 'game' ? '#FFF' : '#718096')
          .borderRadius(12)
          .onClick(() => this.tab = 'game')
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 10 })

      Scroll() {
        Column() {
          if (this.tab === 'words') {
            this.WordsView()
          } else if (this.tab === 'sents') {
            this.SentsView()
          } else {
            this.GameView()
          }
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

  @Builder
  WordsView() {
    Grid({ columns: 2, gutter: 10 }) {
      ForEach(this.words, (w: Word) => {
        GridItem() {
          Column({ space: 4 }) {
            Text(w.e).fontSize(36)
            Text(w.w).fontSize(15).fontWeight(FontWeight.Bold)
            Text(w.p).fontSize(10).fontColor('#A78BFA')
            Text(w.c).fontSize(11).fontColor('#718096')
            Row({ space: 4 }) {
              Text('🔊').fontSize(14).onClick(() => this.speak(w.w))
              Text('🎤').fontSize(14)
            }
          }
          .width('100%')
          .padding({ top: 12, bottom: 10 })
          .backgroundColor(Color.White)
          .borderRadius(16)
        }
      })
    }
    .width('100%')
  }

  @Builder
  SentsView() {
    Column({ space: 10 }) {
      ForEach(this.sents, (s: Sentence, i: number) => {
        Column({ space: 6 }) {
          Row() {
            Text('💬').fontSize(20)
            Column({ space: 2 }) {
              Text(s.q).fontSize(15).fontWeight(FontWeight.Bold)
              Text(s.qc).fontSize(11).fontColor('#718096')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: 8 })
          }
          .width('100%')
          Column({ space: 2 }) {
            Text(s.a).fontSize(14).fontColor('#60A5FA')
            Text(s.ac).fontSize(10).fontColor('#718096')
          }
          .width('100%')
          .padding(8)
          .backgroundColor('#F7FAFC')
          .borderRadius(10)
          Row({ space: 6 }) {
            Text('🔊 问句').fontSize(12).padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor('#FEF3C7').borderRadius(10)
              .onClick(() => this.speak(s.q))
            Text('🔊 答句').fontSize(12).padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor('#DBEAFE').borderRadius(10)
              .onClick(() => this.speak(s.a))
          }
        }
        .width('100%')
        .padding(12)
        .backgroundColor(Color.White)
        .borderRadius(16)
      })
    }
    .width('100%')
  }

  @Builder
  GameView() {
    Column({ space: 10 }) {
      Row() {
        Text('🃏').fontSize(28).width(48).height(48).textAlign(TextAlign.Center)
          .backgroundColor('#FEF3C7').borderRadius(12)
        Column({ space: 2 }) {
          Text('记忆配对').fontSize(14).fontWeight(FontWeight.Bold)
          Text('翻牌找出图片和单词').fontSize(11).fontColor('#718096')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 10 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(16)

      Row() {
        Text('👂').fontSize(28).width(48).height(48).textAlign(TextAlign.Center)
          .backgroundColor('#DBEAFE').borderRadius(12)
        Column({ space: 2 }) {
          Text('听音选词').fontSize(14).fontWeight(FontWeight.Bold)
          Text('听发音选正确单词').fontSize(11).fontColor('#718096')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 10 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(16)

      Row() {
        Text('✏️').fontSize(28).width(48).height(48).textAlign(TextAlign.Center)
          .backgroundColor('#FCE7F3').borderRadius(12)
        Column({ space: 2 }) {
          Text('拼写挑战').fontSize(14).fontWeight(FontWeight.Bold)
          Text('看图片拼出单词').fontSize(11).fontColor('#718096')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 10 })
      }
      .width('100%')
      .padding(12)
      .backgroundColor(Color.White)
      .borderRadius(16)
    }
    .width('100%')
  }
}
