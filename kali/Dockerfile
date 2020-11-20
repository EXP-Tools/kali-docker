FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y


# ----------------------------------------------------------------------------------------
# 全工具安装需 20G 硬盘
# RUN apt-get install kali-linux-everything

# 常用工具安装
RUN apt-get install -y \
    vim procps net-tools telnet netcat tcpdump ftp dos2unix \
    # 渗透框架
    metasploit-framework \
    # 漏洞利用数据库
    exploitdb \
    # 密码爆破
    hydra \
    # 安全列表（常用账密清单等）
    seclists \
    # 网络嗅探
    nmap \ 
    # WIFI 扫描
    aircrack-ng \
    # 合规扫描
    lynis \ 
    # WordPress 扫描
    wpscan \ 
    # Web 应用扫描
    skipfish

# 更新 exploitdb 数据库
RUN searchsploit -u

# Linux 本地提权检查
RUN git clone -b master --single-branch https://github.com/rebootuser/LinEnum /usr/share/LinEnum
# ----------------------------------------------------------------------------------------



# 用于初始化 msf 数据库的脚本（因 docker 内无法执行 systemctl 命令，此 msfdb 脚本被改造过）
# msfdb 初始化成功后会生成配置 /usr/share/metasploit-framework/config/database.yml
# 注： /usr/bin/msfdb 是 /usr/share/metasploit-framework/msfdb 的软链
ADD ./msfdb /usr/share/metasploit-framework/msfdb
RUN chmod a+x /usr/share/metasploit-framework/msfdb


WORKDIR /
CMD ["/bin/bash"]