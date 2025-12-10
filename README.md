# OpenRouter 模型定价比较工具 🚀

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GitHub Actions](https://img.shields.io/badge/Updated-Every%2012%20Hours-blue.svg)](https://github.com/jvrck/openrouterlist/actions)
[![Website](https://img.shields.io/badge/Website-Live-brightgreen.svg)](https://openrouterlist.jvrck.com/)

一个全面的实时定价比较工具，用于比较通过 [OpenRouter API](https://openrouter.ai/) 提供的 400+ AI 语言模型。比较 GPT-4、Claude、Llama、Mistral 和数百种其他模型的成本，为您的 AI 需求找到最具成本效益的解决方案。

**🔗 在线工具: [https://openrouterlist.jvrck.com/](https://openrouterlist.jvrck.com/)**

## 📊 主要功能

- **实时定价数据**: 每 12 小时自动从 OpenRouter API 更新
- **400+ AI 模型**: 全面覆盖所有可用模型，包括 GPT-4、Claude 3、Llama 3 等
- **高级筛选**: 按能力筛选（工具调用、结构化输出、推理、网络搜索）
- **成本计算器**: 显示提示词和补全的每百万令牌定价
- **导出选项**: 下载 CSV、Excel、PDF 格式数据或打印以供离线分析
- **深色模式**: 适合长时间使用的护眼深色主题
- **移动端响应式**: 针对所有设备优化，提供卡片和表格视图

## 🔍 使用场景

- **开发者**: 为您的应用程序找到最具成本效益的模型
- **企业**: 比较企业 AI 解决方案成本
- **研究人员**: 分析不同模型系列的定价趋势
- **预算规划**: 估算 AI 项目的令牌成本

## 📁 项目结构

- `index.html` - 具有高级筛选和搜索功能的交互式网页界面
- `scripts/get_zipped.sh` - 从 OpenRouter API 获取最新定价数据的脚本
- `.github/workflows/daily_run.yml` - 用于数据更新的自动化 GitHub Actions 工作流
- `data/` - JSON 和 CSV 格式的当前模型定价数据
- `robots.txt` - 搜索引擎爬虫指令
- `sitemap.xml` - 用于更好 SEO 索引的站点地图

## 🚀 快速开始

1. 克隆仓库：
    ```bash
    git clone https://github.com/jvrck/openrouterlist.git
    cd openrouterlist
    ```

2. 确保已安装 `jq`、`curl` 和 `zip`：
    ```bash
    sudo apt-get install jq curl zip
    ```

    在 macOS 上：
    ```bash
    brew install jq curl zip
    ```

3. 手动运行脚本：
    ```bash
    bash ./scripts/get_zipped.sh
    ```

4. 在 `results` 文件夹中或 `output.csv` 和 `output.json` 文件中查看结果。

## 🤖 自动更新

定价数据使用 GitHub Actions 每 12 小时自动刷新：

- 每天在 UTC 时间午夜和中午运行更新
- 直接从 OpenRouter API 获取最新定价数据
- 更改自动提交到仓库
- 历史数据归档在带时间戳的 zip 文件中

## 📈 数据字段

比较工具为每个模型显示以下信息：

| 字段 | 描述 |
|-------|-------------|
| **模型 ID** | API 调用的唯一标识符 |
| **模型名称** | 人类可读的模型名称 |
| **创建日期** | 模型发布日期 (YYYY-MM-DD) |
| **上下文长度** | 最大令牌上下文窗口 |
| **提示词成本** | 每 100 万输入令牌的美元价格 |
| **补全成本** | 每 100 万输出令牌的美元价格 |
| **工具调用** | 支持函数/API 调用 |
| **结构化输出** | 返回格式化的 JSON/XML |
| **推理** | 显示逐步思考过程 |
| **响应格式** | 自定义输出格式 |
| **网络搜索** | 可以搜索互联网 |

## 🌐 在线网站

在线访问工具：**[https://openrouterlist.jvrck.com/](https://openrouterlist.jvrck.com/)**

网站功能：
- 实时搜索和筛选
- 导出为 CSV、Excel、PDF
- 深色/浅色主题切换
- 移动端响应式设计
- 为高级用户提供键盘快捷键

## 🤝 贡献

欢迎贡献！请随时：

- 通过 [Issues](https://github.com/jvrck/openrouterlist/issues) 报告错误或请求功能
- 提交改进的拉取请求
- 与可能觉得此工具有用的其他人分享

## 📄 许可证

本项目采用 MIT 许可证 - 详情请参见 [LICENSE](LICENSE) 文件。

## 🔗 相关链接

- [OpenRouter API](https://openrouter.ai/)
- [OpenRouter 文档](https://openrouter.ai/docs)
- [API 定价](https://openrouter.ai/docs#pricing)

---

**关键词**: OpenRouter 定价, AI 模型成本, LLM 定价比较, GPT-4 定价, Claude 定价, Llama 定价, AI API 成本, 模型比较工具, 令牌定价计算器, 语言模型成本, OpenRouter 模型