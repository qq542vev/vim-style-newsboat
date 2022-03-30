<!--
## Document: readme.jbo.md
##
## Manual (Lojban) for Vim Style Newsboat.
##
## Metadata:
##
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.1.4
##   date - 2022-03-30
##   since - 2021-01-15
##   copyright - Copyright (C) 2021 - 2022 qq542vev. Some rights reserved.
##   license - <CC-BY at https://creativecommons.org/licenses/by/4.0/>
##   package - vim-style-newsboat
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/vim-style-newsboat>
##   * <Bag report at https://github.com/qq542vev/vim-style-newsboat/issues>
-->

# .i ni'o la'o .gy. Vim Style Newsboat .gy.

[![.i vidni pixra lo karni liste ku](images/thumbnails/color-feedlist.png)](images/color-feedlist.png ".i vidni pixra lo karni liste ku") [![.i vidni pixra lo nuzba liste ku](images/thumbnails/color-articlelist.png)](images/color-articlelist.png ".i vidni pixra lo nuzba liste ku") [![.i vidni pixra lo nuzba ku](images/thumbnails/color-article.png)](images/color-article.png ".i vidni pixra lo nuzba ku")

.i la'o .gy. Vim Style Newsboat .gy. gunka gunma tezu'e lo nu fukpi tarti lo ka sazri la'o .gy. Keybord .gy. va'o la'o .gy. [Vim](https://www.vim.org/) .gy. .a la'o .gy. [Pentadactyl](https://github.com/pentadactyl/pentadactyl) .gy. la'o .gy. [Newsboat](https://newsboat.org/) .gy. .a la'o .gy. [Newsbeuter](https://github.com/akrennmair/newsbeuter) .gy. kei ku

.i la'o .gy. Vim .gy. me lo ve ciska be fi lo skami ku bei va'o la'o .gy. CLI .gy. ku .i la'o .gy. Pentadactyl .gy. me lo skami tutci be va'o la'o .gy. [Pale Moon](https://www.palemoon.org/) .gy. ku .i la'o .gy. Newsboat .gy. .e la'o .gy. Newsbeuter .gy. me lo skami tutci be lo nu tcidu fi la'o .gy. Feed (RSS / Atom) .gy. kei ku bei va'o la'o .gy. CLI .gy. ku .i fukpi tarti ro lo ka sazri la'o .gy. Keybord .gy. kei ku .inaje ku'i ba'o fukpi tarti lo ka jicmu sazri kei ku

.i ca ca'o gasnu lo nu va'o la'o .gy. newsboat r2.26 .gy. .e la'o .gy. newsbeuter 2.9 .gy. cipra kei ku .i na djuno lo jei va'o lo drata ve farvi ku ka'e zukte kei ku

# .i ni'o tcila

 * .i tai la'o .gy. Vim .gy. noi ke'a srana la'o .gy. `h`, `j`, `k`, `l`, `^F`, `^B`, `G`, `:`, `!`, `/` .gy. ku'o ka'e sazri la'o .gy. Keybord .gy.
 * .i tai la'o .gy. Pentadactyl .gy. noi ke'a srana la'o .gy. `r`, `a`, `f`, `;`, `m`, `b`, `^N`, `^P`, `d` .gy. ku'o ka'e sazri la'o .gy. Keybord .gy.
 * .i lo morna be lo blabi jo'u xekri ku ku .e lo morna be lo carmi skari ku ku zvati
 * .i la'o .gy. Macro .gy. noi sepi'o ke'a ka'e ka'e jarco lo papri ku je cu fukpi la'o .gy. URI .gy. ku'o zvati
 * .i la'o .gy. Filter .gy. .e la'o .gy. Query .gy. vu'o noi ke'a plino xamgu ku'o zvati

# .i ni'o plino tadji

.i e'o pa moi gasnu lo nu da noi ke'a nenri la'o .gy. Home Directory ku'o fukpi la'o .gy. Directory .gy. .e la'o .gy. File .gy. vu'o noi gunka gunma sefi'e ke'a ku'o kei ku .i e'o re moi jmina lo vi jufla ku la'o .gy. `~/.newsboat/config` .gy.

~~~
include "~/.newsboat/bookmark-config"
include "~/.newsboat/color"
include "~/.newsboat/filter"
include "~/.newsboat/keymap"
include "~/.newsboat/macro"
~~~

.i e'o sepa'a lo bangu vanbi be lo skami ciste ku ku galfi lo pagbu be la'o .gy. `~/.newsboat/color` .gy. ku .i mu'a lo ponjo bangu ku vanbi .inaja e'o galfi ra lo vi jufla ku

~~~
# Japanese
highlight article "^フィード：|^見出し：|^作者：|^日付：|^リンク：|^Flags: |^コンテンツ：" white black bold
highlight article "^Links: $" white black bold
~~~

.i ba lo nu zukte la'o .gy. Newsboat .gy. kei ku zo'u jarco lo ka skari tai lo vidni pixra ku kei ku .ije sepu'e zoi .gy. `k` .gy. .a zoi .gy. `j`.gy. vu'o noi ke'a pagbu la'o .gy. Keybord .gy. ku'o ka'e muvdu sazri .inaja snada lo nu stika kei ku

# .i ni'o la'o .gy. Macro .gy.

.i so'o la'o .gy. Macro .gy. zvati la'o .gy. Vim Style Newsboat .gy. .i seja'e lo nu tcidu fi la'o .gy. `~/.newsboat/macro` .gy. kei ku ka'e plino .i va'o lo nu nu'o galfi kei ku sepu'e zoi .gy. `@` .gy. co'a pilno la'o .gy. Macro .gy. .i lo nu ba lo nu catke zoi .gy. `@` .gy. kei ku catke lo vi lerfu batke ku kei ku rinka lo vi fasnu ku

| .i batke | .i tcila ciksi |
| -------- | -------------- |
| `^` | .i movdu lo pa moi gidva notci ku |
| `$` | .i movdu lo ro moi gidva notci ku |
| `0` | .i ba lo nu preti da kei ku gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `1` | .i sepi'o la'o .gy. [FireFox](https://www.mozilla.org/firefox/) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `2` | .i sepi'o la'o .gy. [Chromium](https://www.chromium.org/Home) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `3` | .i benji la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o fu lo nu mrilu kei ku |
| `4` | .i jarco la'o .gy. QR Code .gy. noi ke'a sinxa la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o ku'o |
| `5` | .i sepi'o la'o .gy. [Lynx](http://lynx.browser.org/) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `6` | .i sepi'o la'o .gy. [w3m](http://w3m.sourceforge.net/) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `7` | .i sepi'o la'o .gy. [GNU Wget](https://www.gnu.org/software/wget/) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `8` | .i sepi'o la'o .gy. [curl](https://curl.haxx.se/) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `9` | .i sepi'o la'o .gy. [youtube-dl](https://youtube-dl.org/) .gy. gasnu lo nu kalri la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `i` | .i sepi'o lo ve ciska be fi lo skami ku ku galfi lo nuzba ku |
| `J` | .i ne'i lo liste be lo'i nuzba ku ku ba'o tcidu fi muno lo cnita nuzba ku |
| `K` | .i ne'i lo liste be lo'i nuzba ku ku ba'o tcidu fi muno lo gapru nuzba ku |
| `m` | .i jarco lo liste be lo'i nuzba noi ke'a ckaji la'o .gy. Flag .gy. |
| `o` | .i ba lo nu sepi'o lo ve ciska be fi lo skami ku ku ka'e galfi la'o .gy. URI .gy. noi ke'a judri karni najo nuzba ku'o da kei ku gasnu lo nu kalri da kei ku |
| `O` | .i ba lo nu sepi'o lo ve ciska be fi lo skami ku ku ka'e galfi la'o .gy. URI .gy. noi ke'a judri lo na'e tcidu nuzba ku ku'o da kei ku gasnu lo nu kalri da kei ku |
| `p` | .i va'o la'o .gy. Newsboat .gy. po'o ka'e zukte .i sepi'o la'o .gy. GNU Wget .gy. .onai la'o .gy. curl .gy. cpacu fi la'o .gy. URI .gy. noi ke'a pa moi ku'o .i ti pilno xamgu fi la'o .gy. Podcast .gy. |
| `w` | .i sepi'o lo tutci be lo nu tcidu be fi lo papri ku kei ku ku jarco lo nuzba ku |
| `y` | .i gasnu lo nu fukpi la'o .gy. URI .gy. noi ke'a judri lo karni najo nuzba ku ku'o kei ku |
| `Y` | .i gasnu lo nu fukpi lo jufra be lo nuzba ku ku kei ku |
| `Ctrl-r` | .i curmi jonai to'e curmi la'o .zoi. `auto-reload` .zoi. |

.i va'o lo nu la'o .gy. `xsel` .gy. .a la'o .gy. `xcrip` .gy. zvati lo skami ku kei ku sepi'o la'o .gy. .Clipboard. .gy. ka'e fukpi gasnu .i e'o bu'u la'o .gy. `~/.newsboat/macro` .gy. galfi lo pinta pagbu ku noi ke'a srana la'o .gy. Yank .gy. ku'o .i mu'a pilno la'o .gy. `xsel` .gy. .inaja e'o galfi ra lo vi jufla ku

~~~
macro y set browser "echo %u | xsel --input --primary; echo %u | xsel --input --clipboard" ; open-in-browser ; set browser "${BROWSER:-lynx --} %u"
macro Y pipe-to "tmpFile=$(mktemp); cat >${tmpFile}; cat -- ${tmpFile} | xsel --input --primary; cat -- ${tmpFile} | xsel --input --clipboard; rm -f -- ${tmpFile}"
~~~

# .i ni'o vanbi namcu

.i la'o .gy. Vim Style Newsboat .gy. lanli lo vanbi namcu ku noi vi liste lu'i ke'a ku'o .i seja'e lo nu stika lo vanbi namcu ku kei ku ka'e cenba lo ka zukte kei ku

| .i vanbi namcu cmene | .i tcila ciksi |
| -------------------- | -------------- |
| `BROWSER` | .i le namcu ku me lo srana be la'o .gy. Web Browser .gy. noi pilno ke'a ku'o ku .i va'o lo nu le namcu ku na'e zvati najo kunti kei ku pilno la'o .gy. `lynx` .gy. |
| `EDITOR` | .i le namcu ku me lo srana be lo ve ciska ku ku .i va'o lo nu le namcu ku na'e zvati najo kunti kei ku pilno la'o .gy. `vi` .gy. |
| `MAILER` | .i le namcu ku me lo srana be lo jai sepi'o mrilu ku ku .i lo nu sepu'e la'o .gy. [mailto URI Scheme](https://www.ietf.org/rfc/rfc6068.txt) .gy. ke'a zukte kei ku sarcu lo nu pilno kei ku |
| `PAGER` | .i le namcu ku me lo srana be lo jai sepi'o jarco ku ku .i va'o lo nu le namcu ku na'e zvati najo kunti kei ku pilno la'o .gy. `less` .gy. |
| `VIMSTYLENEWSBOAT_YANKFILE` | .i le namcu ku me lo judri be la'o .gy. File .gy. noi jmina lo fukpi jufra ku ke'a ku'o ku .i va'o lo nu le namcu ku na'e zvati najo kunti kei ku jmina fi la'o .gy. `${HOME}/newsboat-yank` .gy. |
| `VISUAL` | .i le namcu ku me lo srana be lo ve ciska ku ku .i va'o lo nu le namcu ku na'e zvati najo kunti kei ku pilno la'o .gy. `${EDITOR}` .gy. |

# .i ni'o liste lo'i ba se gasnu ku

 * ~~ブックマークへ追加するプログラムの作成~~

# .i ni'o nupre

.i zifre lo nu ka'e gakfi je benji la'o .gy. Vim Style Newsboat .gy. kei ku lo nu tinbe la'o .gy. CC BY 4.0 .gy. kei ku .i e'o tcidu fi la'o .gy. [LICENSE](LICENSE) .gy. noi tepu'e ke'a ciksi lo te nupre ku ku'o

# .i ni'o ckire

.i banai lo nu finti la'o .gy. Vim Style Newsboat .gy. kei ku lanli lo tcila be lo skami tutci ku noi vi liste lu'i ke'a ku'o .i ca'o ckire ro lo finti be lo vi skami tutci ku ku .io sai

 * .i la'o .gy. [Newsboat](https://newsboat.org/) .gy.
 * .i la'o .gy. [Newsbeuter](https://github.com/akrennmair/newsbeuter) .gy.
 * .i la'o .gy. [Vim](https://www.vim.org/) .gy.
 * .i la'o .gy. [Pentadactyl](https://github.com/pentadactyl/pentadactyl) .gy.
