## Introduction

个人工作总结的Linux上软件配置，基本满足工作编程需要，包含如下软件的配置
* NeoVim
* zsh
* tmux
* tmx: 自动创建tmux的脚本

## Changelog
* 2022/10/25: add lsp and FTerm for nvim
* 2022/07/19: add lualine for nvim
* 2022/01/29: only support nvim, remove vimrc
* 2022/01/28: update nvim and vim configurations
* 2021/10/28: update vim
* 2021/10/11: add configuration for nvim
* 2021/10/11: remove fucking vista.vim which can't support cpp
* 2021/10/09: replace Minibufexpl with BufTabline
* 2021/08/12:
   * support vim mouse in Windows Terminal
   * set tmux pane history path
* 2021/06/01:
    * disable leaderF auto gtags update
    * use new markword plugin which can mark more than 6 words
* 2021/05/27: update tmux renumber-windows
* 2021/05/26: change vim colorscheme to my customed PaperColor
* 2020/12/08: change vim colorscheme to solarized
* 2020/09/29: add vim Autoformat pulgin
* 2020/09/8: update tmux statusline configurations 
* 2020/09/4: update tmux statusline configurations 
* 2020/09/3: update tm script to support multiple tmux session
* 2020/09/2: update VIM colorscheme and syntax highlight
* 2020/08/5: 去除leaderF gtags配置，有bug，会自动启动很多gtags进程。添加windows复制粘贴快捷键
* 2020/07/23: 修改statusline配置，添加当前函数tag显示
* 2020/07/17: 添加indentline插件，修改statusline配置
* 2020/07/06: 添加hg repo的gtags自定义update命令
* 2020/07/03: 更新Tmux标签栏背景色配置
* 2020/06/30: 使用LeaderF自动生成gtags索引，使用leaderF gtags代替cscope
* 2020/06/24: 修改LeaderF配置，gtags配置
* 2019/12/9: 添加minibuffexplorer配置，删除ctrlp
* 2019/12/6: 更新colorscheme为Bwhite
* 2018/1/29: 添加python-mode插件，未修改该插件快捷键
* 2018/1/23: 去除csapprox插件，用处不大
* 2018/1/18: 添加YankRing插件，修改快捷键
* 2018/1/5: 初次提交

## NeoVim基本配置
### screenshot

**UI**

![screenshot](ui.png)

**search**

![screenshot](search.png)

### NeoVim profile Installation

**Linux**
```bash
git clone https://github.com/BarretRen/LinuxEnvProfiles.git
cd LinuxEnvProfiles
cp nvim ~/.config
```

**Windosw**
* clone repo
* 将nvim复制到`~/AppData/Local`
* 执行如下vim命令，更新管理器和插件：PlugUpgrade, PlugInstall

--------------------------------------------------------------------------------
