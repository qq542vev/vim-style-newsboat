# Vim Style Newsboat

![Screenshot of Feed List](images/feedlist.png) ![Screenshot of Artcle List](images/artclelist.png) ![Screenshot of Artcle](images/artcle.png)

このプロジェクトは[Vim](https://www.vim.org/), [Pentadactyl](https://github.com/pentadactyl/pentadactyl)のキーボード操作を[Newsboat](https://newsboat.org/)でも実現する試みです。

VimはCLIのスクリーンエディタ、PentadactylはWebブラウザー[Pale Moon](https://www.palemoon.org/)のアドオン、NewsboatはCLIのFeed(RSS/Atom)リーダーです。ソフトウェアの性質の違い故に全てのキーボード操作を模倣出来ている訳ではありませんが、基本的な操作の模倣は完了しております。

テストはnewsboat 2.10.2で行っています。それ以外のバーション及びNewsbeuterでの動作は未確認です。

# 使い方

このプロジェクト内のディレクトリとファイルをそのままホームディレクトリにコピーしてください。その後`~/.newsboat/config`に以下の内容を追加してください。

~~~
include "~/.newsboat/color"
include "~/.newsboat/filter"
include "~/.newsboat/keymap"
include "~/.newsboat/macro"
~~~

ご利用の端末の言語環境に合わせて`~/.newsboat/color`内の一部をコメントアウトします。例えば日本語環境であれば以下のように変更してください。

~~~
# Japanese
highlight article "^フィード：|^見出し：|^作者：|^日付：|^リンク：|^Flag: |^コンテンツ：" white black bold
highlight article "^Links: $" white black bold
~~~

Newsboatを起動しスクリーンショットのような	彩色が反映され、`j`, `k`などで操作出来れば、初期設定は完了です。

# 謝辞

当プロジェクトを作成するにあたり、以下のソフトウェアの機能を利用、若しくは参考にしました。当該ソフトウェアの開発者の皆様に感謝の意を表します。

 * [Newsboat](https://newsboat.org/)
 * [Vim](https://www.vim.org/)
 * [Pentadactyl](https://github.com/pentadactyl/pentadactyl)
