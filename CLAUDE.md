# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在处理此仓库代码时提供指导。

## 项目概述

这是 OpenRouter 模型信息和定价项目，用于获取并显示来自 OpenRouter API 的定价数据。项目通过 GitHub Actions 每 12 小时自动更新模型定价数据，并在位于 https://jvrck.github.io/openrouterlist/ 的 GitHub Pages 上以可搜索、可导出的 HTML 表格形式显示。

## 关键命令

### 手动数据更新
```bash
bash ./scripts/get_zipped.sh
```
此脚本：
- 从 OpenRouter API 获取最新模型数据
- 将 JSON 转换为 CSV 格式
- 在 `results/` 目录中创建带时间戳的结果
- 如果数据已更改，则更新 `data/output.json` 和 `data/output.csv`
- 创建结果的压缩归档

### 所需依赖项
- `jq` - 用于解析 API 响应的 JSON 处理器
- `curl` - 用于 API 调用的 HTTP 客户端  
- `zip` - 压缩工具

在 Ubuntu/Debian 上安装：
```bash
sudo apt-get install jq curl zip
```

在 macOS 上安装：
```bash
brew install jq curl zip
```

## 架构

### 数据流程
1. **数据获取**: `scripts/get_zipped.sh` 调用 OpenRouter API 端点
2. **数据处理**: JSON 响应转换为包含特定字段的 CSV（id、name、created、context_length、pricing.prompt、pricing.completion）
3. **数据存储**: 处理后的数据存储在 `data/` 目录中，并带有时间戳跟踪
4. **展示**: `index.html` 使用 DataTables 库读取 CSV 数据并显示
5. **自动化**: GitHub Actions 工作流（`daily_run.yml`）每天在 UTC 时间午夜和中午运行两次

### 关键组件

- **scripts/get_zipped.sh**: 核心数据获取和处理脚本
  - 创建带时间戳的输出目录
  - 将新数据与现有数据进行比较，避免不必要的更新
  - 维护 `data/updated` 时间戳文件以跟踪上次更新

- **index.html**: 使用 DataTables 的前端显示
  - 动态加载来自 `data/output.csv` 的 CSV 数据
  - 提供搜索、排序、分页和导出功能
  - 显示来自 `data/updated` 的最后更新时间戳

- **.github/workflows/daily_run.yml**: 自动化工作流
  - 在 UTC 时间 00:00 和 12:00 定时运行
  - 仅在数据更改时提交更改
  - 将压缩结果作为 GitHub Actions 工件上传

### 数据格式

项目跟踪以下模型字段：
- 模型 ID（唯一标识符）
- 模型名称（显示名称）
- 创建日期（YYYY-MM-DD 格式）
- 上下文长度（最大令牌上下文）
- 提示词成本（每 100 万令牌的美元价格）
- 补全成本（每 100 万令牌的美元价格）

## 开发说明

- 项目设计为通过自动更新实现免维护
- 所有数据更新都由 GitHub Actions 机器人提交
- `results/` 目录包含历史压缩快照
- 前端使用 CDN 托管的库（jQuery、DataTables）以保持简单
- GitHub Pages 直接从主分支提供静态站点