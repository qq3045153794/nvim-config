#!/bin/bash
#
# Ubuntu NeoVim 一键配置脚本
# 功能：安装 Node.js、NeoVim 并配置 nvim 环境
#
# 使用方法：
#   curl -fsSL https://raw.githubusercontent.com/<your-username>/nvim-config/main/scripts/setup_ubuntu.sh | bash
#   或者
#   git clone https://github.com/<your-username>/nvim-config.git ~/.config/nvim && cd ~/.config/nvim && ./scripts/setup_ubuntu.sh
#

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检测系统架构
detect_arch() {
    local arch="$(uname -m)"
    if [ "$arch" = "x86_64" ]; then
        echo "x64"
    elif [ "$arch" = "aarch64" ]; then
        echo "arm64"
    else
        echo "$arch"
    fi
}

# 安装 Node.js (使用 NodeSource 仓库)
install_nodejs() {
    echo_info "正在安装 Node.js..."

    if command -v node &> /dev/null; then
        local node_version=$(node --version)
        echo_info "Node.js 已安装: $node_version"
        return 0
    fi

    # 安装 Node.js 20.x LTS
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg

    # 添加 NodeSource 仓库
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

    sudo apt-get update
    sudo apt-get install -y nodejs

    echo_info "Node.js 安装完成: $(node --version)"
    echo_info "npm 版本: $(npm --version)"
}

# 安装 NeoVim
install_neovim() {
    echo_info "正在安装 NeoVim..."

    if command -v nvim &> /dev/null; then
        local nvim_version=$(nvim --version | head -n1)
        echo_info "NeoVim 已安装: $nvim_version"
        return 0
    fi

    local arch=$(detect_arch)
    local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz"

    echo_info "下载 NeoVim ($arch)..."
    cd /tmp
    curl -LO "$nvim_url"

    echo_info "解压并安装..."
    sudo tar xzf "nvim-linux-${arch}.tar.gz" -C /usr/local --strip-components=1

    # 清理
    rm -f "nvim-linux-${arch}.tar.gz"

    echo_info "NeoVim 安装完成: $(nvim --version | head -n1)"
}

# 安装系统依赖
install_dependencies() {
    echo_info "正在安装系统依赖..."

    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update

    local deps=(
        git
        curl
        wget
        ripgrep
        fzf
        cmake
        make
        gcc
        g++
        python3
        python3-pip
        python3-venv
        clangd
        clang-format
    )

    for dep in "${deps[@]}"; do
        echo_info "安装 $dep..."
        sudo apt-get install -y "$dep" || echo_warn "无法安装 $dep，跳过"
    done
}

# 安装 Python 依赖
install_python_deps() {
    echo_info "正在安装 Python 依赖..."

    local python="python3"

    # 确保 pip 可用
    if ! $python -m pip --version &> /dev/null; then
        $python -m ensurepip || true
    fi

    local pip_args=""
    if $python -m pip install --help | grep -q break-system-packages; then
        pip_args="--break-system-packages"
    fi

    local packages=(pynvim openai tiktoken cmake_language_server)
    for package in "${packages[@]}"; do
        echo_info "安装 Python 包: $package"
        $python -m pip install -U $pip_args "$package" || echo_warn "无法安装 $package"
    done
}

# 安装 npm 依赖
install_npm_deps() {
    echo_info "正在安装 npm 全局依赖..."

    local registry="--registry=https://registry.npmmirror.com"
    npm install -g pyright $registry || echo_warn "无法安装 pyright"
}

# 配置 nvim
setup_nvim_config() {
    echo_info "正在配置 NeoVim..."

    local config_dir="$HOME/.config/nvim"

    # 如果当前脚本不在 config 目录中运行，则克隆或复制配置
    if [[ ! -d "$config_dir/.git" ]]; then
        echo_info "设置 nvim 配置目录..."

        # 检查是否在 nvim config 目录中运行
        local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
        if [[ "$script_dir" != "$config_dir" ]]; then
            mkdir -p "$config_dir"
            cp -r "$script_dir"/* "$config_dir/"
        fi
    fi

    echo_info "nvim 配置目录: $config_dir"
}

# 安装 Packer 插件管理器
install_packer() {
    echo_info "正在安装 Packer 插件管理器..."

    local packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

    if [[ -d "$packer_dir" ]]; then
        echo_info "Packer 已安装"
        return 0
    fi

    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"
    echo_info "Packer 安装完成"
}

# 安装 nvim 插件
install_plugins() {
    echo_info "正在安装 NeoVim 插件..."

    # 静默安装插件
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>/dev/null || true

    echo_info "插件安装完成"
}

# 主函数
main() {
    echo ""
    echo "========================================"
    echo "   Ubuntu NeoVim 一键配置脚本"
    echo "========================================"
    echo ""

    # 检查是否为 Ubuntu
    if ! grep -q "Ubuntu" /etc/os-release 2>/dev/null; then
        echo_warn "此脚本专为 Ubuntu 设计，在其他系统上可能无法正常工作"
    fi

    install_dependencies
    install_nodejs
    install_neovim
    install_python_deps
    install_npm_deps
    setup_nvim_config
    install_packer
    install_plugins

    echo ""
    echo "========================================"
    echo -e "${GREEN}   安装完成！${NC}"
    echo "========================================"
    echo ""
    echo "运行 'nvim' 启动编辑器"
    echo ""
}

main "$@"
