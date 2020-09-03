## Introduction

个人工作总结的Linux上软件配置，基本满足工作编程需要，包含如下软件的配置
* Vim
* zsh
* tmux
* tm: 自动创建tmux的脚本

> 快捷键基于个人使用习惯，供大家参考。

## Changelog

* 2020/09/3: update tm script to suooprt multiple tmux session
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

## Vim 配置基本介绍
### screenshot

**UI**

![screenshot](ui.png)

**search**

![screenshot](search.png)

### Installation

**Linux**
* git clone https://github.com/Renxiuhu/VimProfiles.git 
* cp -r .vim .vimrc ~/
* vim
* 执行如下vim命令，更新管理器和插件：PlugUpgrade, PlugInstall


**Windows**

* git clone https://github.com/Renxiuhu/VimProfiles.git
* 将库中内容复制到用户个人目录中(.tmux.conf是关于TMUX的配置，可以删除）
* 将.vimrc重命名为_vimrc, 将.vim重命名为vimfiles
* 启动vim
* 执行如下vim命令，更新管理器和插件：PlugUpgrade, PlugInstall


### Usage

**Key Mapping:**

| 按键             | 含义          |
| -------------   |:-------------|
| F2              | 关闭当前buffer                                |
| F3              | 退出vim                                       |
| F4              | 保存文件                                      |
| F5              | 打开文件浏览器                                |
| F6              | 打开tagbar                                   |
| F7              | 查找光标位置的词语                             |
| F8              | 替换光标位置的词语                             |
| F11             | 开关代码缩进线                                 |
| F12             | 打开文件历史记录                               |
| w  v            | 垂直分割当前窗口                               |
| w  x            | 水平分割当前窗口                               |
| w  c            | 关闭当前窗口                                   |
| l  n            | 开关行号                                      |
| f  x            | 打开quickfix窗口                              |
| a  s            | 调用AsyncRun执行异步操作                       |
| t               | vim中打开shell                                |
| b  u            | 打开buffer list                               |
| f  u            | 打开当前文件函数列表                            |
| f  s            | 在当前目录下搜索光标下文本                     |
| m               | 标记光标下词语                                 |
| Ctrl n          | 新建buffer                                    |
| Ctrl c          | 复制                                          |
| Ctrl x          | 剪切                                          | 
| Ctrl v          | 粘贴                                          |
| Ctrl a          | 全选                                          |
| Ctrl \          | 注释、反注释                                   |
| Ctrl p          | 打开文件搜索                                   |
| f    r          | 搜索光标下符号出现位置（需要gtags支持） |
| f    d          | 搜索光标下符号定义位置（需要gtags支持） |
| f    c          | 搜索光标下函数被调用的位置（需要gtags支持） |

--------------------------------------------------------------------------------
