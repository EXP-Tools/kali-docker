FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# 全工具安装需 20G 硬盘
# RUN apt-get install kali-linux-everything

# 安装常用工具
RUN apt-get install -y \
    vim procps net-tools netcat tcpdump \
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


ADD ./init.sh /init.sh
CMD ["/init.sh"]