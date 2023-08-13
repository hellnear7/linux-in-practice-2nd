FROM ubuntu:20.04

# タイムゾーンを日本に設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update && apt-get install -y \
  binutils build-essential golang sysstat python3-matplotlib python3-pil fonts-takao \
  fio qemu-kvm virt-manager libvirt-clients virtinst jq docker.io containerd libvirt-daemon-system \
  strace sudo

# dockerコンテナアクセス用ユーザ(study)作成
RUN useradd -m -s /bin/bash study

# studyユーザーをsudoersに追加
RUN echo "study ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# studyユーザを libvirt libvirt-qemu kvm グループに追加
RUN adduser study libvirt
RUN adduser study libvirt-qemu
RUN adduser study kvm

# studyユーザーにdockerグループを追加
RUN usermod -aG docker study

# studyユーザーでログインできるようにする
USER study

# マウントポイント作成
RUN mkdir -p /home/study/linux-in-practice-2nd

# マウントポイントに移動
WORKDIR /home/study/linux-in-practice-2nd