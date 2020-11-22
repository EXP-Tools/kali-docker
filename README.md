# kali-docker

> docker 一键部署 kali 渗透测试环境

------

## 简介

kali 是提供的官方镜像 [kali-rolling](https://hub.docker.com/r/kalilinux/kali-rolling) 是不含任何渗透工具的纯净版系统，一些常用的渗透工具（如 msf、hydra 等）需要额外安装。

虽然可以一键安装 kali 全家桶工具，但是需要占用 20G 硬盘空间且安装时间非常长，再者不是所有工具都是我们日常必须用到的，因此本着适用优先的原则做了此项目。


## 目录结构

```
kali-docker
├── README.md .................. [此 README 说明]
├── docker-compose.yml ......... [docker 编排剧本]
├── kali
│   ├── Dockerfile ............. [docker 构建剧本]
│   └── msfdb .................. [为兼容 docker 而修改过的 msf 数据库管理脚本]
├── pgdb ....................... [msf 数据库数据挂载目录，用于数据迁移]
├── run.ps1 .................... [Windows: 一键部署并进入 kali 环境]
├── run.sh ..................... [Linux: 一键部署并进入 kali 环境]
├── stop.ps1 ................... [Windows: 一键停止 kali 服务]
└── stop.sh .................... [Linux: 一键停止 kali 服务]
```

<details>
<summary>关于 msfdb 脚本</summary>
<br/>

即 `/usr/bin/msfdb` 脚本，本用于控制 msf 数据库的初始化、启动、停止等。

但是由于该脚本涉及到 `systemctl` 命令，因此在 docker 环境无法直接使用。

不过本项目把 msf 的 pg 数据库以容器形式部署，因此不需要使用此脚本管理数据库的启停，但是需要利用该脚本的初始化能力，因此这里针对其初始化相关的代码做了一定的修改，主要修改的地方有 3 处：

- 注释 `init_db()` 方法的 `start_db` 语句以避免 `systemctl` 命令调用
- 注释 `init_db()` 方法的 `DB_PASS=$(pw_gen)` 语句，使用与 [docker-compose.yml](docker-compose.yml) 相同的固定密码而非随机密码
- 修改输出到 `/usr/share/metasploit-framework/config/database.yml` 的 `DB_HOST` 配置与 [docker-compose.yml](docker-compose.yml) 所分配的 PG 数据库 IP 一致（原本固定为 localhost）

以后若新版本的 msf 框架不适用此脚本，可据此对应修改新版本的 `/usr/bin/msfdb` 脚本。

</details>


## 部署指引

- 宿主机安装 docker、docker-compose
- 下载仓库： `git clone https://github.com/lyy289065406/kali-docker`
- 构建镜像并运行：
    - Linux: `cd kali-docker && ./run.sh`
    - Windows: `cd kali-docker && ./run.ps1`


## 默认工具清单

通过修改 [`kali/Dockerfile`](kali/Dockerfile) 文件可以自定义期望安装的工具，默认已安装的渗透工具清单如下：

| 工具 | 描述 | 使用 |
|:----:|:----:|:----|
| [metasploit-framework](https://github.com/rapid7/metasploit-framework) | MSF 渗透框架 | 执行 `msfconsole` 命令可进入 msf 环境<br/>详见[官方文档](https://tools.kali.org/exploitation-tools/metasploit-framework) |
| [exploitdb](https://github.com/offensive-security/exploitdb) | 漏洞利用数据库 | 每周可执行一次 `searchsploit -u` 命令更新数据库<br/>[官方文档](https://tools.kali.org/exploitation-tools/exploitdb) |
| [hydra](https://github.com/vanhauser-thc/thc-hydra) | 账密爆破工具 | [官方文档](https://tools.kali.org/password-attacks/hydra) |
| [seclists](https://github.com/danielmiessler/SecLists) | 安全列表（常用账密清单等） | 清单目录在 `/usr/share/seclists`<br/>详见[官方文档](https://tools.kali.org/password-attacks/seclists) |
| [nmap](https://github.com/nmap/nmap) | 网络嗅探 | [官方文档](https://tools.kali.org/information-gathering/nmap) |
| [LinEnum](https://github.com/rebootuser/LinEnum) | Linux 本地提权检查工具 | shell 脚本在 `/usr/share/LinEnum/LinEnum.sh` |
| [aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) | WIFI 扫描 | [官方文档](https://tools.kali.org/wireless-attacks/aircrack-ng) |
| [lynis](https://github.com/CISOfy/lynis) | 合规扫描 | [官方文档](https://tools.kali.org/vulnerability-analysis/lynis) |
| [wpscan](https://github.com/wpscanteam/wpscan) | WordPress 扫描 | [官方文档](https://tools.kali.org/web-applications/wpscan) |
| [skipfish](https://github.com/spinkham/skipfish) | Web 应用扫描 | [官方文档](https://tools.kali.org/web-applications/skipfish) |

> 可通过 `apt-get install kali-linux-everything` 命令安装 kali 全家桶工具，在 [https://tools.kali.org/](https://tools.kali.org/) 可找到大部分 kali 工具的使用指引
