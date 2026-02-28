# NeoVim Configuration

基于 [Packer](https://github.com/wbthomason/packer.nvim) 的 NeoVim 配置，专为 C/C++、Python、Lua 开发优化。

## 功能特性

- **LSP 支持** - 代码补全、跳转、重构（支持 clangd、pyright 等）
- **文件管理** - NvimTree 文件浏览器
- **模糊搜索** - Telescope 查找文件、文本、符号
- **Git 集成** - Neogit、Gitsigns
- **终端集成** - ToggleTerm 浮动终端
- **代码格式化** - Neoformat + LSP format
- **调试支持** - DAP、CMake Tools
- **AI 辅助** - Avante、nvim-gpt
- **其他** - 自动补全、自动保存、注释、括号匹配等

## 快速安装

### Ubuntu 一键安装

```bash
git clone https://github.com/qq3045153794/nvim-config ~/.config/nvim
cd ~/.config/nvim
./scripts/setup_ubuntu.sh
```

安装脚本会自动：
- 安装 Node.js 20.x LTS
- 安装最新版 NeoVim
- 安装系统依赖（ripgrep, fzf, cmake 等）
- 安装 Python 和 npm 依赖
- 安装 Packer 插件管理器
- 安装所有 NeoVim 插件

### 手动安装

```bash
# 1. 安装 NeoVim 0.9+
# Ubuntu/Debian:
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

# 2. 安装依赖
./scripts/install_deps.sh

# 3. 克隆配置
git clone https://github.com/<your-username>/nvim-config.git ~/.config/nvim

# 4. 安装 Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# 5. 安装插件
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

## 键位映射

### 光标移动（已重新映射）
| 按键 | 功能 |
|------|------|
| `j` | 左 |
| `k` | 下 |
| `i` | 上 |
| `l` | 右 |
| `J` / `K` / `L` / `I` | 快速移动（5倍） |
| `jk` | 退出插入模式 |

### 功能键
| 按键 | 功能 |
|------|------|
| `F4` | 保存所有文件 |
| `F5` | 运行/调试（CMake/PlatformIO） |
| `Shift+F5` | 停止运行 |
| `F6` | 切换 Quickfix/Trouble 列表 |
| `F8` | 切换终端 |
| `F9` | 切换诊断列表 |
| `F10` | 打开 Neogit |
| `Ins` | 切换禅模式 |

### LSP 相关
| 按键 | 功能 |
|------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gr` | 查找引用 |
| `gy` | 跳转到类型定义 |
| `gY` | 查找实现 |
| `gn` | 重命名符号 |
| `gw` | 代码修复 |
| `H` | 查看文档（Hover） |
| `go` | 切换头文件/源文件 |

### 窗口管理
| 按键 | 功能 |
|------|------|
| `Ctrl+h/j/k/l` | 切换窗口 |
| `Alt+s` | 水平分割 |
| `Alt+v` | 垂直分割 |
| `Alt+x` | 交换窗口 |
| `Ctrl+q` | 关闭窗口 |

### 其他
| 按键 | 功能 |
|------|------|
| `q` | 关闭当前 Buffer |
| `Q` | 退出 NeoVim |
| `F` | 在 NvimTree 中定位当前文件 |
| `gsp` | 切换文件树 |
| `gso` | 切换代码大纲 |
| `gsg` | 打开 Neogit |
| `Ctrl+s` | 格式化代码 |

## 目录结构

```
~/.config/nvim/
├── init.vim              # 入口文件
├── lua/
│   ├── archvim/
│   │   ├── config/       # 插件配置
│   │   ├── predownload/  # 预下载的插件
│   │   ├── init.lua      # 主模块
│   │   ├── mappings.lua  # 键位映射
│   │   ├── options.lua   # 编辑器选项
│   │   └── plugins.lua   # 插件列表
│   └── overseer/         # Overseer 任务配置
├── scripts/
│   ├── setup_ubuntu.sh   # Ubuntu 一键安装脚本
│   ├── install_deps.sh   # 依赖安装脚本
│   └── install_nvim.sh   # NeoVim 安装脚本
└── dotfiles/             # 其他配置文件
```

## 依赖

### 必需
- NeoVim >= 0.9
- Git
- Node.js & npm（用于 LSP）
- Python 3 & pip（用于部分插件）

### 推荐
- ripgrep（Telescope 搜索）
- fzf（模糊搜索）
- cmake & make（C/C++ 开发）
- clangd（C/C++ LSP）
- pyright（Python LSP）

## 自定义配置

创建 `.vim_localrc` 文件添加本地配置，该文件会被自动加载且不会被 git 追踪。

## 许可证

MIT License
