# 键位

## 基础

**Leader 键：** `<Space>`（空格键）

### 文件操作

- `<Leader>w` - 保存文件
- `<Leader>q` - 退出
- `<Leader>qq` - 强制退出所有窗口
- `<Leader>x` - 保存并退出

### 窗口分屏

- `<C-h>` - 移动到左窗口
- `<C-j>` - 移动到下窗口
- `<C-k>` - 移动到上窗口
- `<C-l>` - 移动到右窗口
- `<Leader>vs` - 垂直分屏
- `<Leader>hs` - 水平分屏

### 缓冲区管理

- `<Tab>` - 下一个缓冲区
- `<S-Tab>` - 上一个缓冲区
- `<Leader>bd` - 删除当前缓冲区

## 编辑快捷键

### 文本操作

- `<Leader>a` - 全选
- `J` - 合并行（保持光标位置）
- `J`（视觉模式）- 向下移动选中行
- `K`（视觉模式）- 向上移动选中行

### 搜索增强

- `n` - 下一个搜索结果（居中显示）
- `N` - 上一个搜索结果（居中显示）

### 注释

- `gc` - 切换注释（普通和视觉模式）

## 文件浏览 (Telescope)

- `<Leader>ff` - 查找文件
- `<Leader>fg` - 全局搜索
- `<Leader>fb` - 查找缓冲区
- `<Leader>fh` - 查找帮助
- `<Leader>fr` - 恢复上次搜索
- `<Leader>fs` - 文档符号搜索

## 文件树 (NvimTree)

- `<Leader>e` - 切换文件树
- `<Leader>ef` - 在文件树中定位当前文件

## LSP 代码导航

### 跳转

- `gd` - 跳转到定义
- `gD` - 跳转到声明
- `gr` - 查找引用
- `gi` - 跳转到实现
- `K` - 悬停信息

### 代码操作

- `<Leader>rn` - 重命名
- `<Leader>ca` - 代码操作
- `<Leader>f` - 格式化代码

### 诊断

- `[d` - 上一个诊断
- `]d` - 下一个诊断
- `<Leader>d` - 显示诊断浮窗
- `<Leader>dl` - 诊断列表

## 代码补全 (nvim-cmp)

- `<C-b>` - 向上滚动文档
- `<C-f>` - 向下滚动文档
- `<C-Space>` - 触发补全
- `<C-e>` - 取消补全
- `<CR>` - 确认选择

## Copilot AI 助手

- `<Tab>` - 接受 Copilot 建议
- `<C-]>` - 下一个建议
- `<C-[>` - 上一个建议
- `<C-/>` - 拒绝建议
- `<M-CR>` - 打开 Copilot 面板

### Copilot 面板内

- `[[` - 上一个建议
- `]]` - 下一个建议
- `gr` - 刷新
- `q` - 关闭面板

## 快速跳转 (Flash)

- `s` - 快速跳转到字符
- `S` - Treesitter 智能跳转

## 文本选择 (Treesitter)

- `gnn` - 开始增量选择
- `grn` - 扩展选择到节点
- `grc` - 扩展选择到作用域
- `grm` - 缩小选择

## 调试器 (DAP)

### 断点管理

- `<leader>db` - 切换断点

### 调试控制

- `<leader>dc` - 继续执行
- `<leader>dj` - 步过（Step Over）
- `<leader>dk` - 步入（Step Into）
- `<leader>do` - 步出（Step Out）
- `<leader>dt` - 终止调试

### 调试界面

- `<leader>dus` - 设置 DAP UI
- `<leader>duc` - 关闭 DAP UI
- `<leader>dut` - 切换 DAP UI

### 调试工具

- `<leader>dr` - 打开 REPL
- `<leader>dl` - 运行上次配置

## 终端

- `<Leader>t` - 打开终端
- `<Esc>`（终端模式）- 退出终端模式到普通模式
