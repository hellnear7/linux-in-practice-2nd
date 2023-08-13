#/bin/sh

# このシェルスクリプトのあるディレクトリに移動する
cd $(dirname $0)

# linux_sikmiというタグのイメージがなければ、Dockerfileからイメージを作成する
grep linux_sikmi <<< $(docker images) || docker build -t linux_sikmi .

# ./Dockerfileのコンテナを作成し、linx-in-practice-2ndをマウントした状態で起動する
docker run -it --rm -v $(pwd):/home/study/linux-in-practice-2nd linux_sikmi /bin/bash