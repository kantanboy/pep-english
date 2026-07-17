# PEP小学英语 - 鸿蒙版

人教PEP版小学英语，三年级起点，适配 HarmonyOS。

## 功能特性

- 📚 **三年级至六年级**：上下册共48个单元，完整覆盖人教PEP词汇和句型
- 🎤 **复读跟读**：语音识别评分，发音练习更有针对性
- 🦊 **小狐狸吉祥物**：AI 互动陪伴，答对欢呼、答错安慰
- 🎮 **互动游戏**：记忆配对、听音选词、拼写挑战
- ⭐ **奖励系统**：星星收集、贴纸解锁、宝箱开箱、等级晋升
- 📅 **每日打卡**：连续签到奖励，培养学习习惯

## 编译 .hap 文件

### 方式一：GitHub Actions 云端编译（推荐）

无需本地 DevEco Studio，自动构建生成 .hap 文件。

**步骤：**

1. **创建 GitHub 仓库**
   ```bash
   git init
   git add .
   git commit -m "init: PEP小学英语鸿蒙版"
   git branch -M main
   git remote add origin https://github.com/你的用户名/pep-english.git
   git push -u origin main
   ```

2. **查看构建结果**
   - 进入 GitHub 仓库 → Actions 标签页
   - 点击最新的 workflow run 查看构建日志
   - 构建完成后，在 Summary 页面下载 Artifact（hap 文件）

3. **触发方式**
   - 每次 push 到 main/master 分支自动触发
   - 支持手动触发（Actions → Build HAP → Run workflow）

**输出文件：**
- Debug 版：`entry/build/outputs/hap/debug/entry-default-unsigned.hap`
- Release 版：`entry/build/outputs/hap/release/entry-default-unsigned.hap`

> ⚠️ 云端编译产物为 **未签名** 版本，安装到真机需要额外签名（见下方签名说明）。

### 方式二：本地 DevEco Studio 编译

**环境要求**
- DevEco Studio 3.1.0 或更高版本
- HarmonyOS SDK API 10 或更高

**编译步骤**

1. **打开项目**
   启动 DevEco Studio → Open Project → 选择 `PEPEnglish` 目录

2. **同步项目**
   File → Sync Project with Gradle Files

3. **签名配置**
   File → Project Structure → Signing Configs → 添加您的华为开发者证书

4. **编译 HAP**
   Build → Build Hap(s) → 选择 `entry` 模块

5. **输出位置**
   编译完成后，.hap 文件位于：
   ```
   entry/build/outputs/hap/debug/entry-default-signed.hap
   ```

### 签名配置（安装到真机必须）

云端编译的 .hap 是**未签名**的，鸿蒙系统要求所有安装到真机的应用必须签名。

**步骤：**
1. 加入 [华为开发者联盟](https://developer.huawei.com/)（免费）
2. 使用华为 AppGallery Connect 生成签名证书
3. 下载证书文件（.p12 + .cer）
4. 在 `build-profile.json5` 中配置 signingConfigs
5. 重新编译或手动对 .hap 签名

> 💡 如果只是模拟器测试，部分版本无需签名即可安装。

### 安装到手机

**方法一：DevEco Studio 直接运行**
1. 鸿蒙手机开启开发者模式（设置→系统→开发者选项）
2. USB 连接电脑
3. DevEco Studio 点击 Run ▶️

**方法二：手动安装**
1. 将 `.hap` 文件发送到手机
2. 手机文件管理器打开 → 安装
3. 首次安装需在设置中信任该应用

## 项目结构

```
PEPEnglish/
├── .github/workflows/           # GitHub Actions CI/CD
│   └── build-hap.yml          # 自动构建 .hap 工作流
├── AppScope/                    # 应用级配置
│   ├── app.json5              # 应用基本信息
│   └── resources/              # 应用资源
├── entry/                       # 主模块
│   ├── src/main/
│   │   ├── ets/               # ArkTS 源码
│   │   │   ├── entryability/  # 应用入口
│   │   │   └── pages/         # 页面
│   │   ├── module.json5       # 模块配置
│   │   └── resources/         # 模块资源
│   ├── build-profile.json5    # 构建配置
│   ├── hvigorfile.ts          # 构建脚本
│   └── oh-package.json5       # 依赖配置
├── hvigor/                      # 构建工具配置
├── hvigorfile.ts               # 项目构建脚本
├── build-profile.json5         # 项目构建配置
├── oh-package.json5            # 项目依赖
├── package.json                # 项目信息
└── .gitignore                   # Git 忽略规则
```

## 数据来源

- 单词、句型数据参考人教PEP版英语教材（2024新版）
- 音标采用国际音标 IPA 标注
- 图片使用 emoji 代替真实图片，无需额外资源

## 技术栈

- **页面框架**：ArkUI (声明式 UI)
- **数据存储**：\@ohos.data.preferences (首选项) + \@ohos.data.relationalStore (关系型数据库)
- **语音能力**：\@ohos.multimedia.audio (音频) + AI 语音识别
- **动画**：ArkUI 内置动画 + 转场动画

## 后续计划

- [ ] 接入华为 TTS 引擎实现单词发音
- [ ] 接入华为 AI 语音识别实现复读评分
- [ ] 接入关系型数据库存储学习进度
- [ ] 添加更多互动游戏模式
- [ ] 支持离线下载教材音频
- [ ] 添加学习报告和家长监控

## 许可证

Apache-2.0
