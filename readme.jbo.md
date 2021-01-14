# .i ni'o la'o .gy. Vim Style Newsboat .gy.

[![.i vidnyxra lo karni liste ku](images/thumbnails/color-feedlist.png)](images/color-feedlist.png ".i vidnyxra lo karni liste ku") [![.i vidnyxra lo nuzba liste ku](images/thumbnails/color-articlelist.png)](images/color-articlelist.png ".i vidnyxra lo nuzba liste ku") [![.i vidnyxra lo nuzba ku](images/thumbnails/color-article.png)](images/color-article.png ".i vidnyxra lo nuzba ku")

.i la'o .gy. Vim Style Newsboat .gy. gungunma tezu'e lo nu fuktra lo lercu'aca'a sazri ku pe la'o .gy. [Vim](https://www.vim.org/) .gy. .a la'o .gy. [Pentadactyl](https://github.com/pentadactyl/pentadactyl) .gy. la'o .gy. Newsboat .gy. kei ku

.i la'o .gy. Vim .gy. me lo ve ciska be fi lo skami ku ku .i la'o .gy. Pentadactyl .gy. me lo jmina tutci ku pe lo la'o .gy. [Pale Moon](https://www.palemoon.org/) .gy. kibyca'o ku .i la'o .gy. Newsboat .gy. .e la'o .gy. Newsbeuter .gy. me lo skami tutci be lo du'u cpacu la'o .gy. Feed(RSS/Atom) .gy. kei ku .i fuktra ro lo lercu'aca'a sazri ku .inaje ba'o fuktra lo jicmu sazri ku

.i ca ca'o gasnu lo nu va'o la'o .gy. newsboat r2.22 .gy. .e la'o .gy. newsbeuter 2.9 .gy. cipra kei ku .i na djuno lo jei va'o da'a re lo ve farvi ku zukte kei ku

# .i ni'o tcila

 * .i tai la'o .gy. Vim .gy. ne la'o .gy. `h`, `j`, `k`, `l`, `^F`, `^B`, `G`, `:`, `!`, `/` .gy. lercu'aca'a sazri
 * .i tai la'o .gy. Pentadactyl .gy. ne la'o .gy. `r`, `a`, `f`, `;`, `m`, `b`, `^N`, `^P`, `d` .gy. lercu'aca'a sazri
 * .i lo blabi janai xekri ku .e lo carmi skari ku stura
 * .i zvati la'o .gy. Macro .gy. ne lo nu sepi'o lo za'u pa kibyca'o ku kargau la'o .gy. URI .gy. kei je nu fukpi kei ku
 * .i zvati lo du'u la'o .gy. Filter .gy. .e la'o .gy. Query .gy. plixau kei ku

# .i plino tadji

.i e'o pa moi gasnu lo nu lo datnyveiste ku pe mi fukpi lo ke datnyveiste je datnyvei ke'e be ne'i lo vi gungunma ku ku kei ku .i e'o re moi jmina lo bavla'i jufla ku la'o .gy. `~/.newsboat/config` .gy.

~~~
include "~/.newsboat/color"
include "~/.newsboat/filter"
include "~/.newsboat/keymap"
include "~/.newsboat/macro"
~~~

.i e'o ji'u lo bangu vanbi be lo skami ciste ku ku galfi la'o .gy. `~/.newsboat/color` .gy. .i mu'a vanbi lo ponjo bangu ku .inaja e'o galfi ra lo bavla'i jufla ku

~~~
# Japanese
highlight article "^フィード：|^見出し：|^作者：|^日付：|^リンク：|^Flags: |^コンテンツ：" white black bold
highlight article "^Links: $" white black bold
~~~

.i zukte la'o .gy. Newsboat .gy. .ije jarco lo ka skari tai lo vidnyxra ku kei ku .ije sepu'e la'o .gy. `j`, `k` .gy. pe lo lercu'aca'a ku muvdu ka'e sazri .inaja snada lo te ciste ku

## .i ni'o la'o .gy. Macro .gy.

.i so'o la'o .gy. Macro .gy. zvati la'o .gy. Vim Style Newsboat .gy. .i seja'e lo nu tcidu fi la'o .gy. `~/.newsboat/macro` .gy. kei ku ka'e plino .i va'o lo se galfi ku zoi .gy. `@` .gy. li'enrafsi la'o .gy. Macro .gy. .i lo nu ba zoi .gy. `@` .gy. catke lo bavla'i tekla ku kei ku rinka lo bavla'i fasnu ku

| .i tekla | .i tcila ciksi                                                                                                               |
| -------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `^`      | .i movdu lo pa mai gidva notci ku                                                                                            |
| `$`      | .i movdu lo ro mai gidva notci ku                                                                                            |
| `0`      | .i ba lo nu preti da kei ku sepi'o da kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku                                   |
| `1`      | .i sepi'o la'o .gy. [FireFox](https://www.mozilla.org/firefox/) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku    |
| `2`      | .i sepi'o la'o .gy. [Chromium](https://www.chromium.org/Home) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku      |
| `3`      | .i benji la'o .gy. URI .gy. pe lo karni jonai nuzba ku fu lo kibro mrilu ku                                                  |
| `4`      | .i jarco la'o .gy. QR Code .gy. poi galfi la'o .gy. URI .gy. pe lo karni jonai nuzba ku ke'a ku'o                            |
| `5`      | .i sepi'o la'o .gy. [Lynx](http://lynx.browser.org/) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku               |
| `6`      | .i sepi'o la'o .gy. [w3m](http://w3m.sourceforge.net/) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku             |
| `7`      | .i sepi'o la'o .gy. [GNU Wget](https://www.gnu.org/software/wget/) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku |
| `8`      | .i sepi'o la'o .gy. [curl](https://curl.haxx.se/) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku                  |
| `9`      | .i sepi'o la'o .gy. [youtube-dl](https://youtube-dl.org/) .gy. kargau la'o .gy. URI .gy. pe lo karni jonai nuzba ku          |
| `i`      | .i sepi'o lo ve ciska be fi skami ku kargau lo nuzba ku                                                                      |
| `m`      | .i jarco lo liste be lo'i nuzba pe la'o .gy. Flag .gy.                                                                       |
| `y`      | .i gasnu lo nu fukpi la'o .gy. URI .gy. pe lo karni jonai nuzba ku kei ku                                                    |
| `Y`      | .i gasnu lo nu fukpi lo jufra ku pe lo nuzba ku kei ku                                                                       |

.i la'o .gy. `xsel` .gy. .a la'o .gy. `xcrip` .gy. zvati lo skami ku .inaja sepi'o la .kuripubod. ka'e fukpi gasnu .i e'o galfi lo du'u ne'i la'o .gy. `~/.newsboat/macro` .gy. ra'a la'o .gy. Yank .gy. pinpau kei ku .i mu'a pilno la'o .gy. `xsel` .gy. .inaja e'o galfi ra lo bavla'i jufla ku

~~~
macro y set browser "echo %u | xsel --input --primary; echo %u | xsel --input --clipboard" ; open-in-browser ; set browser "${BROWSER:-lynx --} %u"
macro Y pipe-to "tmpFile=$(mktemp); cat >${tmpFile}; cat -- ${tmpFile} | xsel --input --primary; cat -- ${tmpFile} | xsel --input --clipboard; rm -f -- ${tmpFile}"
~~~

## .i ni'o vanbi goilka'i

.i la'o .gy. Vim Style Newsboat .gy. lanli lo vanbi goilka'i ku pe lo bavla'i liste ku .i seja'e lo nu galfi lo vanbi goilka'i namcu ku kei ku ka'e cenba lo zu'o zukte kei ku

| .i vanbi goilka'i cmene        | .i tcila ciksi |
| --------------------------- | ----------- |
| `BROWSER`                   | le namcu ku me lo pilno kibyca'o ku .i le vanbi goilka'i ku na zvati .ijonai le namcu ku kunti .inaja pilno la'o .gy. `lynx` .gy. |
| `EDITOR`                   | le namcu ku me lo pilno ve ciska ku .i le vanbi goilka'i ku na zvati .ijonai le namcu ku kunti .inaja pilno la'o .gy. `vi` .gy. |
| `MAILER`                    | le namcu ku me lo jai sepi'o kibro mrilu ku .i nitcu ri poi sepu'e la'o .gy. [mailto URI Scheme](https://www.ietf.org/rfc/rfc6068.txt) .gy. ke'a zukte ku'o |
| `VIMSTYLENEWSBOAT_YANKFILE` | le namcu ku me lo jai bu'u datnyvei ku poi jmina lo fukpi jufra ku ke'a ku'o .i le vanbi goilka'i ku na zvati .ijonai lo namcu ku kunti .inaja pilno la'o .gy. `${HOME}/newsboat-yank` .gy. |
| `VISUAL`                    | le namcu ku me lo pilno ve ciska ku .i le vanbi goilka'i ku na zvati .ijonai le namcu ku kunti .inaja pilno la'o .gy. `${EDITOR}` .gy. |

# ToDo

 * ブックマークへ追加するプログラムの作成

# .i ni'o lo te bilga ku

.i ja'i la'o .gy. CC BY 4.0 .gy. to'e mipri la'o .gy. Vim Style Newsboat .gy. .i zifre lo nu galfi ja to'e mipri kei ku lo du'u tinbe la'o .gy. CC BY 4.0 .gy. kei ku .i lo tcila be lo te bilga ku ku zo'u catlu e'o la'o .gy. [LICENSE](LICENSE) .gy.

# .i ckire

.i pu lo nu co'a finti la'o .gy. Vim Style Newsboat .gy. kei ku lanli lo samtci ku pe lo bavla'i liste ku i ca'o ckire ro loi finti be lo va samtci ku ku .io

 * .i la'o .gy. [Newsboat](https://newsboat.org/) .gy.
 * .i la'o .gy. [Vim](https://www.vim.org/) .gy.
 * .i la'o .gy. [Pentadactyl](https://github.com/pentadactyl/pentadactyl) .gy.
