# Vim Style Newsboat

[![Screenshot of Feed List](images/thumbnails/color-feedlist.png)](images/color-feedlist.png "Screenshot of Feed List") [![Screenshot of Artcle List](images/thumbnails/color-articlelist.png)](images/color-articlelist.png "Screenshot of Artcle List") [![Screenshot of Artcle](images/thumbnails/color-article.png)](images/color-article.png "Screenshot of Artcle")

Vim Style Newsboatは[Vim](https://www.vim.org/), [Pentadactyl](https://github.com/pentadactyl/pentadactyl)のキーボード操作を[Newsboat](https://newsboat.org/)でも実現する試みです。

VimはCLIのスクリーンエディタ、PentadactylはWebブラウザー[Pale Moon](https://www.palemoon.org/)のアドオン、NewsboatはCLIのFeed(RSS/Atom)リーダーです。ソフトウェアの性質の違い故に全てのキーボード操作を模倣出来ている訳ではありませんが、基本的な操作の模倣は完了しております。

テストはnewsboat 2.10.2で行っています。それ以外のバーション及び[Newsbeuter](https://www.newsbeuter.org/)での動作は未確認です。

# 機能

 * `h`, `j`, `k`, `l`, `^F`, `^B`, `G`, `:`, `!`, `/`などのVim風のキーボード操作
 * `r`, `a`, `f`, `;`, `m`, `b`, `^N`, `^P`, `d`などのPentadactyl風のキーボード操作
 * ダークとモノクロームの2種類のカラースキーム
 * Webブラウザーの切り替えやヤンクなどのマクロを定義
 * 便利なフィルターとクエリの定義

# 使い方

このプロジェクト内のディレクトリとファイルをそのままホームディレクトリにコピーしてください。その後`~/.newsboat/config`に以下の内容を追加してください。

~~~
include "~/.newsboat/color"
include "~/.newsboat/filter"
include "~/.newsboat/keymap"
include "~/.newsboat/macro"
~~~

ご使用の端末の言語環境に合わせて`~/.newsboat/color`内の一部をコメントアウトします。例えば日本語環境であれば以下のように変更してください。

~~~
# Japanese
highlight article "^フィード：|^見出し：|^作者：|^日付：|^リンク：|^Flags: |^コンテンツ：" white black bold
highlight article "^Links: $" white black bold
~~~

Newsboatを起動しスクリーンショットのような	彩色が反映され、`j`, `k`などで操作出来れば、初期設定は完了です。

## マクロ

Vim Style Newsboatでは幾つのマクロが定義されており、`~/.newsboat/macro`を読み込むと使用可能です。デフォルトのマクロプレフィックスは`@`であり、それに続けて当該キーを押すと以下の動作を行います。

| キー | 詳細説明                                                                              |
| ---- |-------------------------------------------------------------------------------------- |
| `^`  | 最初のダイアログに移動します。                                                        |
| `$`  | 最後のダイアログに移動します。                                                        |
| `1`  | 現在のフィードか記事のURLを[FireFox](https://www.mozilla.org/firefox/)で開きます。    |
| `2`  | 現在のフィードか記事のURLを[Chromium](https://www.chromium.org/Home)で開きます。      |
| `3`  | 現在のフィードか記事のURLをEメールで送信します。                                      |
| `5`  | 現在のフィードか記事のURLを[Lynx](http://lynx.browser.org/)で開きます。               |
| `6`  | 現在のフィードか記事のURLを[w3m](http://w3m.sourceforge.net/)で開きます。             |
| `7`  | 現在のフィードか記事のURLを[GNU Wget](https://www.gnu.org/software/wget/)で開きます。 |
| `8`  | 現在のフィードか記事のURLを[curl](https://curl.haxx.se/)で開きます。                  |
| `9`  | 現在のフィードか記事のURLを[youtube-dl](https://youtube-dl.org/)で開きます。          | 
| `i`  | 現在の記事をテキストエディタで開きます。                                              |
| `m`  | フラグが付けられた記事の一覧を開きます。                                              |
| `o`  | 現在のフィードか記事のURLをテキストエディタで開き、そのURLをWebブラウザーで開きます。 |
| `O`  | 未読記事のURLをテキストエディタで開き、そのURLをWebブラウザーで開きます。             | 
| `y`  | 現在のフィードか記事のURLをヤンクします。                                             |
| `Y`  | 現在の記事の内容をヤンクする。                                                        |

`xsel`や`xclip`がインストールされている場合、ヤンクにクリップボードを使用することも可能です。`~/.newsboat/macro`内のヤンクに関する当該行をコメントアウトしてください。例えば`xsel`を使用する場合は以下の行を有効にしてください。

~~~
macro y set browser "echo %u | xclip -selection 'primary'; echo %u | xclip -selection 'clipboard'" ; open-in-browser ; set browser "${BROWSER-lynx --} %u"
macro Y pipe-to "tmpFile=$(mktemp); cat >${tmpFile}; cat -- ${tmpFile} | xsel --input --primary; cat -- ${tmpFile} | xsel --input --clipboard; rm -f -- ${tmpFile}"
~~~

## 環境変数

Vim Style Newsboatでは以下の環境変数を参照します。環境変数の値を変更することにより、動作の変更が可能です。

| 環境変数名                  | 詳細説明                                                                                                                              |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `BROWSER`                   | 使用するWebブラウザーを指定します。この変数が存在しない場合か、値が空文字列の場合には`lynx`を使用します。                             |
| `EDITOR`                    | 使用するテキストエディタを指定します。この変数が存在しない場合か、値が空文字列の場合には`vi`を使用します。                            |
| `MAILER`                    | 使用するメーラーを指定します。メーラーは[mailtoスキーム](https://tools.ietf.org/rfc/rfc6068.txt)が処理可能である必要があります。      |
| `VIMSTYLENEWSBOAT_YANKFILE` | ヤンクした内容を追加するファイルを指定します。この変数が存在しない場合か、値が空文字列の場合には`${HOME}/newsboat-yank`を使用します。 |
| `VISUAL`                    | 使用するテキストエディタを指定します。この変数が存在しない場合か、値が空文字列の場合には`${EDITOR}`を使用します。                     |

# ToDo

 * ブックマークへ追加するプログラムの作成

# ライセンス

Vim Style NewsboatはCC BY 4.0で配布されています。このライセンスに従う限りに於いて自由に改変や再配布を行えます。ライセンスの詳細は[LICENSE](LICENSE)を参照してください。

# 謝辞

Vim Style Newsboatを作成するにあたり、以下のソフトウェアの機能を使用、若しくは参考にしました。当該ソフトウェアの開発者の皆様に感謝の意を表します。

 * [Newsboat](https://newsboat.org/)
 * [Vim](https://www.vim.org/)
 * [Pentadactyl](https://github.com/pentadactyl/pentadactyl)
