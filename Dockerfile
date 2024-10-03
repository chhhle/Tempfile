# 使用Ubuntu 16.04作為基底映像
FROM ubuntu:16.04

# 更新套件並安裝Python 3.5和其他必要的工具
RUN apt-get update && apt-get install -y \
    python3.5 \
    python3.5-venv \
    python3-pip \
    && apt-get clean

# 設定工作目錄
WORKDIR /app

# 複製當前目錄下的所有檔案到容器的 /app 目錄中
COPY . /app

# 建立虛擬環境，但不安裝任何套件
RUN python3.5 -m venv env

# 安裝舊版的 pip，但不安裝其他任何依賴
RUN /bin/bash -c "source env/bin/activate && pip install pip==20.3.4"

# 將當前目錄加入到 Python 路徑
RUN echo $PWD > env/lib/python3.5/site-packages/sgan.pth

# 保持容器運行，不執行任何安裝或運行命令
CMD ["/bin/bash"]