概要<br>
sinatra + jQueryを用いて実装しています。
実数部・虚数部の範囲と複素定数のパラメータに応じたジュリア集合を描画します。
ジュリア集合の計算はC拡張を使用しています。各ピクセルの配色データを配列にしてリスポンスを返しており、データを受け取ったjQueryがcanvas要素に描画しています。パラメータに整数、少数、複素数以外が入力されると、400エラーを返し、エラーメッセージを表示させています。
ジュリア集合の計算では反復回数を100、複素数点の絶対値の臨界値を200に設定しています。色付けはhue形式の色相値を5×(発散時の反復回数)で設定しています。

苦労した点<br>
ジュリア集合の描画に苦労しました。c拡張で計算した後、どうやって画像を出力するのか悩みました。cでファイルの作成まで行った方が、処理も早くいいのではと考えましたが、外部ライブラリを用いずに作成する方法が分かりませんでした。ppmファイルを試しましたが、htmlで扱うことが難しいと知り、最終的に描画はフロントエンドに任せることにしました。
またバリデーションに関しても、外部ライブラリを用いない手法がなかなか見つからず苦労しました。

工夫したこと、見てほしいところ<br>
当初はrailsで実装するつもりでしたが、「プロジェクト構成、モジュール構成に配慮すること」とあったため、できるだけシンプルな構成にするためsinatraを使いました。
C拡張の引数では複素定数を実数部と虚数部でそれぞれ受け取るようにしています。複素定数を受けとり、Cコード内でrubyの関数を呼び出すより、最初から分けて渡す方がシンプルでいいのではだと考えました。
バリデーションでは各パラメータを小数等に変換する過程で、文字列や空白等のバリデーションをしています。

感想<br>
　sinatraやc拡張など初めて触る要素が多く最初は不安でした。進めるなかで外部ライブラリの制限で思いのほか苦労しましたが、最終的に形になってよかったです。sinatraに関しては、使い始めてから情報の少なさに驚きました。ちょうどdockerを勉強していたので、dockerで環境構築を行いましたが、ここでも時間がかかり焦りました。
　終わってみると、sinatraやC拡張、画像の描画等について勉強になってよかったと思っています。

環境構築<br>
docker を使用する場合<br>
プロジェクトのルートディレクトリで<br>
- $ docker compose build
- $ docker compose up -d

dockerを使用しない場合(ruby 3.1.4)<br>
プロジェクトのルートディレクトリで<br>
- $ RUN gem install bundler && bundle install
- $ bundle exec rackup --host 0.0.0.0 -p 8080

C拡張を再ビルドが必要な場合は<br>
ext/juliaディレクトリで<br>
- $ make clean
- $ rm Makefile
- $ ruby extconf.rb
- $ make

開発環境<br>
言語・フレームワーク<br>
- ruby 3.1.4
- sinatra 3.2.0
- JavaScript
- jQuery
- HTML, CSS
インフラ<br>
- puma 6.4.1
- Docker 24.0.7
- wsl Ubuntu 20.04
