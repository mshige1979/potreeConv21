# potreeConv21

## 注意

おそらくソフトウェアのバージョンでビルドが不安定になる。
v1.6 は最新環境でも動くが、1.7 は怪しい

## 環境

| OS/ツール    | バージョン          |
| ------------ | ------------------- |
| Ubuntu       | 20.04               |
| gcc.g++      | 9.4(apt-get の最新) |
| cmake        | 3.21.4              |
| PotreeConver | 2.1                 |
| tbb          | 最新                |

## 手順

### git clone

```
https://github.com/mshige1979/potreeConv21.git
```

### ビルド

```
cd potreeConv21
docker build -t potreeconv21 .
```

### 起動

```
docker run -d -it -v $PWD/input:/input -v $PWD/output:/output \
  -p 1234:1234 --name [任意のコンテナ名] potreeconv21
```

### LAS ファイル変換

```
docker run --rm \
    -v $PWD/input:/input -v $PWD/output:/output \
    potreeconv21 /opt/PotreeConverter/PotreeConverter \
      [入力ファイル] \
      -o [出力ディレクトリ] \
      --generate-page [ページ名]
```

### bash

```
docker exec -it [任意のコンテナ名] /bin/bash
```

#### コンテナ内からの LAS ファイルの変換

```
/opt/PotreeConverter/PotreeConverter \
    /input/scaniverse-20211105-170039.las \
    -o /output/test1 \
    --generate-page test1
```

↓

```
# tree /output/test1/ -I libs
/output/test1/
|-- pointclouds
|   `-- test1
|       |-- hierarchy.bin
|       |-- metadata.json
|       `-- octree.bin
`-- test1.html
```
