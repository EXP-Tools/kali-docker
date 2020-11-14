FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# 全工具安装需 20G 硬盘
# RUN apt-get install kali-linux-everything

# 常用工具安装
RUN apt-get install -y \
    vim procps net-tools telnet netcat tcpdump ftp \
    # 渗透框架
    metasploit-framework \
    # 密码爆破
    hydra \
    # 网络扫描
    nmap \ 
    # WIFI 扫描
    aircrack-ng \
    # 合规扫描
    lynis \ 
    # WordPress 扫描器
    wpscan \ 
    # Web 应用扫描器
    skipfish


# 用于初始化 msf 数据库的脚本（因 docker 内无法执行 systemctl 命令，此 msfdb 脚本被改造过）
# msfdb 初始化成功后会生成配置 /usr/share/metasploit-framework/config/database.yml
ADD ./msfdb /usr/bin/msfdb
RUN chmod a+x /usr/bin/msfdb


WORKDIR /
CMD ["/bin/bash"]