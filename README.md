# rx-cocoa-mvvm-example-login-form-ios

RxSwiftを使ったViewModelのInputのstreamをOutputのstreamに一括変換するサンプル

## 対応OS

- iOS 15以上

## 開発環境

- Xcode 13

## ライブラリ

ライブラリは全てCocoaPodsで管理している。

### 初期設定

リポジトリをCloneしたらアプリをビルドするために以下が必要になる。

rbenvを使って.ruby-versionで指定されているバージョンのRubyをインストールする。

MacにBundlerがインストールされていない場合はBundlerをインストールする。

Gemfileが置かれているディレクトリで以下を実行してCocoaPodsをインストールする。

```sh
$ bundle install
```

Podfileが置かれているディレクトリで以下を実行してライブラリをインストールする。

```sh
$ bundle exec pod install
```