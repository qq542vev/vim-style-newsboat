#!/usr/bin/env sh

### Script: addbookmark.sh
##
## ブックマークを追加する。
##
## Metadata:
##
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 3.0.8
##   date - 2022-10-28
##   since - 2021-09-09
##   copyright - Copyright (C) 2021 - 2022 qq542vev. Some rights reserved.
##   license - <CC-BY at https://creativecommons.org/licenses/by/4.0/>
##   package - vim-style-newsboat
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/vim-style-newsboat>
##   * <Bug report at https://github.com/qq542vev/vim-style-newsboat/issues>
##
## Help Output:
##
## ------ Text ------
## Usage:
##   addbookmark.sh [OPTION]... [URL] [TITLE] [DESCRIPTION] [SECTION_NAME]
##
## Options:
##   -d,     --{no-}duplicate    重複を許容する
##   -e,     --{no-}empty-section 
##                               空のセクションを許容する
##   -f,     --file FILE         ブックマークファイルを指定する
##   -p,     --position bottom | none | top 
##                               ブックマークアイテムを追加する位置を指定する
##   -h,     --help              このヘルプを表示して終了する
##   -v,     --version           バージョン情報を表示して終了する
##
## Exit Status:
##     0 - successful termination
##    64 - command line usage error
##    65 - data format error
##    66 - cannot open input
##    67 - addressee unknown
##    68 - host name unknown
##    69 - service unavailable
##    70 - internal software error
##    71 - system error (e.g., can't fork)
##    72 - critical OS file missing
##    73 - can't create (user) output file
##    74 - input/output error
##    75 - temp failure; user is invited to retry
##    76 - remote error in protocol
##    77 - permission denied
##    78 - configuration error
##   129 - received SIGHUP
##   130 - received SIGINT
##   131 - received SIGQUIT
##   143 - received SIGTERM
##
## Environment Variables:
##   ADDBOOKMARK_BEGIN_BOOKMARK_SYMBOL - ブックマークの開始を示すシンボル
##   ADDBOOKMARK_END_BOOKMARK_SYMBOL   - ブックマークの終了を示すシンボル
##   ADDBOOKMARK_BEGIN_SECTION_SYMBOL  - ブックマークセクションの開始を示すシンボル
##   ADDBOOKMARK_END_SECTION_SYMBOL    - ブックマークセクションの終了を示すシンボル
##   ADDBOOKMARK_BEGIN_LIST_SYMBOL     - ブックマークリストの開始を示すシンボル
##   ADDBOOKMARK_END_LIST_SYMBOL       - ブックマークリストの終了を示すシンボル
##   ADDBOOKMARK_SECTION_TEMPLATE      - ブックマークセクションのテンプレート
##   ADDBOOKMARK_ITEM_TEMPLATE         - ブックマークアイテムのテンプレート
## ------------------

readonly 'VERSION=addbookmark.sh 3.0.3'

set -efu
umask '0022'
LC_ALL='C'
IFS=$(printf ' \t\n_'); IFS="${IFS%_}"
PATH="${PATH-}${PATH:+:}$(command -p getconf 'PATH')"
UNIX_STD='2003' # HP-UX POSIX mode
XPG_SUS_ENV='ON' # AIX POSIX mode
XPG_UNIX98='OFF' # AIX UNIX 03 mode
POSIXLY_CORRECT='1' # GNU Coreutils POSIX mode
COMMAND_MODE='unix2003' # macOS UNIX 03 mode
export 'IFS' 'LC_ALL' 'PATH' 'UNIX_STD' 'XPG_SUS_ENV' 'XPG_UNIX98' 'POSIXLY_CORRECT' 'COMMAND_MODE'

readonly 'EX_OK=0'           # successful termination
readonly 'EX__BASE=64'       # base value for error messages

readonly 'EX_USAGE=64'       # command line usage error
readonly 'EX_DATAERR=65'     # data format error
readonly 'EX_NOINPUT=66'     # cannot open input
readonly 'EX_NOUSER=67'      # addressee unknown
readonly 'EX_NOHOST=68'      # host name unknown
readonly 'EX_UNAVAILABLE=69' # service unavailable
readonly 'EX_SOFTWARE=70'    # internal software error
readonly 'EX_OSERR=71'       # system error (e.g., can't fork)
readonly 'EX_OSFILE=72'      # critical OS file missing
readonly 'EX_CANTCREAT=73'   # can't create (user) output file
readonly 'EX_IOERR=74'       # input/output error
readonly 'EX_TEMPFAIL=75'    # temp failure; user is invited to retry
readonly 'EX_PROTOCOL=76'    # remote error in protocol
readonly 'EX_NOPERM=77'      # permission denied
readonly 'EX_CONFIG=78'      # configuration error

readonly 'EX__MAX=78'        # maximum listed value

trap 'case "${?}" in 0) end_call;; *) end_call "${EX_SOFTWARE}";; esac' 0 # EXIT
trap 'end_call 129' 1  # SIGHUP
trap 'end_call 130' 2  # SIGINT
trap 'end_call 131' 3  # SIGQUIT
trap 'end_call 143' 15 # SIGTERM

### Function: end_call
##
## 一時ディレクトリを削除しスクリプトを終了する。
##
## Parameters:
##
##   $1 - 終了ステータス。
##
## Returns:
##
##   $1 の終了ステータス。

end_call() {
	trap '' 0 # EXIT
	rm -fr -- ${tmpDir:+"${tmpDir}"}
	exit "${1:-0}"
}

### Function: option_error
##
## エラーメッセージを出力する。
##
## Parameters:
##
##   $1 - エラーメッセージ。
##
## Returns:
##
##   終了コード64。

option_error() {
	printf '%s: %s\n' "${0##*/}" "${1}" >&2
	printf "詳細については '%s' を実行してください。\\n" "${0##*/} --help" >&2

	end_call "${EX_USAGE}"
}

### Function: awkv_escape
##
## 文字列内の AWK 特殊文字をエスケープする。
##
## Parameters:
##
##   $1 - 結果を代入する変数名。
##   $2 - エスケープする文字列。
##
## See Also:
##
##   * <4.2 POSIX 準拠シェル 用 at https://qiita.com/ko1nksm/items/a22c0ce88e39c9f2dcb0#42-posix-%E6%BA%96%E6%8B%A0%E3%82%B7%E3%82%A7%E3%83%AB-%E7%94%A8>

awkv_escape() {
	set -- "${1}" "${2}" ''
	until [ "${2#*\\}" '=' "${2}" ]; do
		set -- "${1}" "${2#*\\}" "${3}${2%%\\*}\\\\"
	done

	set -- "${1}" "${3}${2}"
	case "${2}" in
		@*) set -- "${1}" "\\100${2#?}";;
	esac

	eval "${1}=\${2}"
}

# $1: ret, $2: value, $3: from, $4: to
replace_all_fast() {
  eval "$1=\${2//\"\$3\"/\"\$4\"}"
}

# $1: ret, $2: value, $3: from, $4: to
replace_all_posix() {
  set -- "$1" "$2" "$3" "$4" ""
  until [ _"$2" = _"${2#*"$3"}" ] && eval "$1=\$5\$2"; do
    set -- "$1" "${2#*"$3"}" "$3" "$4" "$5${2%%"$3"*}$4"
  done
}

# $1: ret, $2: value, $3: from, $4: to
replace_all_pattern() {
  set -- "$1" "$2" "$3" "$4" ""
  until eval "[ _\"\$2\" = _\"\${2#*$3}\" ] && $1=\$5\$2"; do
    eval "set -- \"\$1\" \"\${2#*$3}\" \"\$3\" \"\$4\" \"\$5\${2%%$3*}\$4\""
  done
}

meta_escape() {
  # shellcheck disable=SC1003
  if [ "${1#*\?}" ]; then # posh <= 0.5.4
    set -- '\\\\:\\\\\\\\' '\\\[:[[]' '\\\?:[?]' '\\\*:[*]' '\\\$:[$]'
  elif [ "${2%%\\*}" ]; then # bosh = all (>= 20181007), busybox <= 1.22.0
    set -- '\\\\:\\\\\\\\' '\[:[[]' '\?:[?]' '\*:[*]' '\$:[$]'
  else # POSIX compliant
    set -- '\\:\\\\' '\[:[[]' '\?:[?]' '\*:[*]' '\$:[$]'
  fi

  set "$@" '\(:\\(' '\):\\)' '\|:\\|' '\":\\\"' '\`:\\\`' \
    '\{:\\{' '\}:\\}' "\\':\\\\'" '\&:\\&' '\=:\\=' '\>:\\>' "end"

  echo 'meta_escape() { set -- "$1" "$2" ""'
  until [ "$1" = "end" ] && shift && printf '%s\n' "$@"; do
    set -- "${1%:*}" "${1#*:}" "$@"
    set -- "$@" 'until [ _"$2" = _"${2#*'"$1"'}" ] && set -- "$1" "$3$2" ""; do'
    set -- "$@" '  set -- "$1" "${2#*'"$1"'}" "$3${2%%'"$1"'*}'"$2"'"'
    set -- "$@" 'done'
    shift 3
  done
  echo 'eval "$1=\"\$3\$2\""; }'
}
eval "$(meta_escape "a?" "\\")"

replace_all() {
  (eval 'v="*#*/" p="#*/"; [ "${v//"$p"/-}" = "*-" ]') 2>/dev/null && return 0
  [ "${1#"$2"}" = "a*b" ] && return 1 || return 2
}
eval 'replace_all "a*b" "a[*]" &&:' &&:
case $? in
  0) # Fast version (Not POSIX compliant)
    # ash(busybox)>=1.30.1, bash>=3.1.17, dash>=none, ksh>=93?, mksh>=54
    # yash>=2.30?, zsh>=3.1.9?, pdksh=none, posh=none, bosh=none
    replace_all() { replace_all_fast "$@"; }; ;;
  1) # POSIX version (POSIX compliant)
    # ash(busybox)>=1.1.3, bash>=2.05b, dash>=0.5.2, ksh>=93q, mksh>=40
    # yash>=2.30?, zsh>=3.1.9?, pdksh=none, posh=none, bosh=none
    replace_all() { replace_all_posix "$@"; }; ;;
  2) # Pattern version
    replace_all() {
      meta_escape "$1" "$3"
      eval "replace_all_pattern \"\$1\" \"\$2\" \"\${$1}\" \"\$4\""
    }
esac

replace_multiple() {
	eval "${1}=\"\${2}\""
	eval "shift 2; set -- '${1}'" '${@+"${@}"}'

	while [ 2 -le "${#}" ]; do
		eval 'replace_all "${1}"' "\"\${${1}}\"" '"${2}" "${3-}"'

		case "${#}" in
			'2') set --;;
			*) eval "shift 3; set -- '${1}'" '${@+"${@}"}';;
		esac
	done
}

### Function: html_escape
##
## 文字列内の HTML 特殊文字を実態参照に変換する。
##
## Parameters:
##
##   $1 - 結果を代入する変数名。
##   $2 - 実態参照に変換する文字列。

html_escape() {
	replace_multiple "${1}" "${2}" '&' '&amp;' '<' '&lt;' '>' '&gt;' "'" '&#39;' '"' '&quot;'
}

### Function: remove_control_character
##
## 文字列内の C0, C1 制御文字を削除する。
##
## Parameters:
##
##   $1 - 結果を代入する変数名。
##   $2 - 対象の文字列。
##   $3 - 除外する制御文字。

remove_control_character() {
	set -- "${1}" "${2}" "${3}" "$(printf '\001\002\003\004\005\006\007\010\011\012\013\014\015\016\017\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037\177\200\201\202\203\204\205\206\207\210\211\212\213\214')"

	while [ -n "${3}" ]; do
		replace_all "${1}" "${4}" "${3%%${3#?}}" ''

		eval 'set -- "${1}" "${2}" "${3#?}"' "\"\${${1}}\""
	done

	set -- "${1}" "${2}" "${4}" ''

	while [ -n "${3}" ]; do
		set -- "${1}" "${2}" "${3#?}" "${4} '${3%%${3#?}}' ''"
	done

	eval 'replace_multiple "${1}" "${2}"' "${4}"
}

### Function: safe_string
##
## 文字列内の水平タブ、改行、復帰以外の制御文字を削除する。
##
## Parameters:
##
##   $1 - 結果を代入する変数名。
##   $2 - 対象の文字列。

safe_string() {
	remove_control_character "${1}" "${2}" "$(printf '\t\n\r')"
}

### Function: comment_escape
##
## 文字列内の改行文字、ハイフンを文字参照に変換する。
##
## Parameters:
##
##   $1 - 結果を代入する変数名。
##   $2 - 対象の文字列。

comment_escape() {
	replace_multiple "${1}" "${2}" '
' '&#10;' '' '&#13;' '-' '&#45;'
}

# @getoptions
parser_definition() {
	setup REST plus:true abbr:true error:option_error no:0 help:usage \
		-- 'Usage:' "  ${2##*/} [OPTION]... [URL] [TITLE] [DESCRIPTION] [SECTION_NAME]" \
		'' 'Options:'

	flag  duplicateFlag    -d --{no-}duplicate     init:@no -- '重複を許容する'
	flag  emptySectionFlag -e --{no-}empty-section init:@no -- '空のセクションを許容する'
	param bookmarkFile     -f --file               init:'bookmarkFile="${HOME}/bookmark.html"' var:FILE -- 'ブックマークファイルを指定する'
	param position         -p --position           init:='bottom' pattern:'bottom | none | top' var:'bottom | none | top' -- 'ブックマークアイテムを追加する位置を指定する'
	disp  :usage           -h --help    -- 'このヘルプを表示して終了する'
	disp  VERSION          -v --version -- 'バージョン情報を表示して終了する'

	msg -- '' 'Exit Status:' \
		'    0 - successful termination' \
		'   64 - command line usage error' \
		'   65 - data format error' \
		'   66 - cannot open input' \
		'   67 - addressee unknown' \
		'   68 - host name unknown' \
		'   69 - service unavailable' \
		'   70 - internal software error' \
		"   71 - system error (e.g., can't fork)" \
		'   72 - critical OS file missing' \
		"   73 - can't create (user) output file" \
		'   74 - input/output error' \
		'   75 - temp failure; user is invited to retry' \
		'   76 - remote error in protocol' \
		'   77 - permission denied' \
		'   78 - configuration error' \
		'  129 - received SIGHUP' \
		'  130 - received SIGINT' \
		'  131 - received SIGQUIT' \
		'  143 - received SIGTERM'


	msg -- '' 'Environment Variables:' \
		'  ADDBOOKMARK_BEGIN_BOOKMARK_SYMBOL - ブックマークの開始を示すシンボル' \
		'  ADDBOOKMARK_END_BOOKMARK_SYMBOL   - ブックマークの終了を示すシンボル' \
		'  ADDBOOKMARK_BEGIN_SECTION_SYMBOL  - ブックマークセクションの開始を示すシンボル' \
		'  ADDBOOKMARK_END_SECTION_SYMBOL    - ブックマークセクションの終了を示すシンボル' \
		'  ADDBOOKMARK_BEGIN_LIST_SYMBOL     - ブックマークリストの開始を示すシンボル' \
		'  ADDBOOKMARK_END_LIST_SYMBOL       - ブックマークリストの終了を示すシンボル' \
		'  ADDBOOKMARK_SECTION_TEMPLATE      - ブックマークセクションのテンプレート' \
		'  ADDBOOKMARK_ITEM_TEMPLATE         - ブックマークアイテムのテンプレート'
}
# @end

# @gengetoptions parser -i parser_definition parse "${1}"
# Generated by getoptions (BEGIN)
# URL: https://github.com/ko1nksm/getoptions (v3.3.0)
duplicateFlag='0'
emptySectionFlag='0'
bookmarkFile="${HOME}/bookmark.html"
position='bottom'
REST=''
parse() {
  OPTIND=$(($#+1))
  while OPTARG= && [ $# -gt 0 ]; do
    set -- "${1%%\=*}" "${1#*\=}" "$@"
    while [ ${#1} -gt 2 ]; do
      case $1 in (*[!a-zA-Z0-9_-]*) break; esac
      case '--duplicate' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --duplicate"
      esac
      case '--no-duplicate' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --no-duplicate"
      esac
      case '--empty-section' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --empty-section"
      esac
      case '--no-empty-section' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --no-empty-section"
      esac
      case '--file' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --file"
      esac
      case '--position' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --position"
      esac
      case '--help' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --help"
      esac
      case '--version' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --version"
      esac
      break
    done
    case ${OPTARG# } in
      *\ *)
        eval "set -- $OPTARG $1 $OPTARG"
        OPTIND=$((($#+1)/2)) OPTARG=$1; shift
        while [ $# -gt "$OPTIND" ]; do OPTARG="$OPTARG, $1"; shift; done
        set "Ambiguous option: $1 (could be $OPTARG)" ambiguous "$@"
        option_error "$@" >&2 || exit $?
        echo "$1" >&2
        exit 1 ;;
      ?*)
        [ "$2" = "$3" ] || OPTARG="$OPTARG=$2"
        shift 3; eval 'set -- "${OPTARG# }"' ${1+'"$@"'}; OPTARG= ;;
      *) shift 2
    esac
    case $1 in
      --?*=*) OPTARG=$1; shift
        eval 'set -- "${OPTARG%%\=*}" "${OPTARG#*\=}"' ${1+'"$@"'}
        ;;
      --no-*|--without-*) unset OPTARG ;;
      -[fp]?*) OPTARG=$1; shift
        eval 'set -- "${OPTARG%"${OPTARG#??}"}" "${OPTARG#??}"' ${1+'"$@"'}
        ;;
      -[dehv]?*) OPTARG=$1; shift
        eval 'set -- "${OPTARG%"${OPTARG#??}"}" -"${OPTARG#??}"' ${1+'"$@"'}
        OPTARG= ;;
      +*) unset OPTARG ;;
    esac
    case $1 in
      '-d'|'--duplicate'|'--no-duplicate')
        [ "${OPTARG:-}" ] && OPTARG=${OPTARG#*\=} && set "noarg" "$1" && break
        eval '[ ${OPTARG+x} ] &&:' && OPTARG='1' || OPTARG='0'
        duplicateFlag="$OPTARG"
        ;;
      '-e'|'--empty-section'|'--no-empty-section')
        [ "${OPTARG:-}" ] && OPTARG=${OPTARG#*\=} && set "noarg" "$1" && break
        eval '[ ${OPTARG+x} ] &&:' && OPTARG='1' || OPTARG='0'
        emptySectionFlag="$OPTARG"
        ;;
      '-f'|'--file')
        [ $# -le 1 ] && set "required" "$1" && break
        OPTARG=$2
        bookmarkFile="$OPTARG"
        shift ;;
      '-p'|'--position')
        [ $# -le 1 ] && set "required" "$1" && break
        OPTARG=$2
        case $OPTARG in bottom | none | top) ;;
          *) set "pattern:bottom | none | top" "$1"; break
        esac
        position="$OPTARG"
        shift ;;
      '-h'|'--help')
        usage
        exit 0 ;;
      '-v'|'--version')
        echo "${VERSION}"
        exit 0 ;;
      --)
        shift
        while [ $# -gt 0 ]; do
          REST="${REST} \"\${$(($OPTIND-$#))}\""
          shift
        done
        break ;;
      [-+]?*) set "unknown" "$1"; break ;;
      *)
        REST="${REST} \"\${$(($OPTIND-$#))}\""
    esac
    shift
  done
  [ $# -eq 0 ] && { OPTIND=1; unset OPTARG; return 0; }
  case $1 in
    unknown) set "Unrecognized option: $2" "$@" ;;
    noarg) set "Does not allow an argument: $2" "$@" ;;
    required) set "Requires an argument: $2" "$@" ;;
    pattern:*) set "Does not match the pattern (${1#*:}): $2" "$@" ;;
    notcmd) set "Not a command: $2" "$@" ;;
    *) set "Validation error ($1): $2" "$@"
  esac
  option_error "$@" >&2 || exit $?
  echo "$1" >&2
  exit 1
}
usage() {
cat<<'GETOPTIONSHERE'
Usage:
  addbookmark.sh [OPTION]... [URL] [TITLE] [DESCRIPTION] [SECTION_NAME]

Options:
  -d,     --{no-}duplicate    重複を許容する
  -e,     --{no-}empty-section 
                              空のセクションを許容する
  -f,     --file FILE         ブックマークファイルを指定する
  -p,     --position bottom | none | top 
                              ブックマークアイテムを追加する位置を指定する
  -h,     --help              このヘルプを表示して終了する
  -v,     --version           バージョン情報を表示して終了する

Exit Status:
    0 - successful termination
   64 - command line usage error
   65 - data format error
   66 - cannot open input
   67 - addressee unknown
   68 - host name unknown
   69 - service unavailable
   70 - internal software error
   71 - system error (e.g., can't fork)
   72 - critical OS file missing
   73 - can't create (user) output file
   74 - input/output error
   75 - temp failure; user is invited to retry
   76 - remote error in protocol
   77 - permission denied
   78 - configuration error
  129 - received SIGHUP
  130 - received SIGINT
  131 - received SIGQUIT
  143 - received SIGTERM

Environment Variables:
  ADDBOOKMARK_BEGIN_BOOKMARK_SYMBOL - ブックマークの開始を示すシンボル
  ADDBOOKMARK_END_BOOKMARK_SYMBOL   - ブックマークの終了を示すシンボル
  ADDBOOKMARK_BEGIN_SECTION_SYMBOL  - ブックマークセクションの開始を示すシンボル
  ADDBOOKMARK_END_SECTION_SYMBOL    - ブックマークセクションの終了を示すシンボル
  ADDBOOKMARK_BEGIN_LIST_SYMBOL     - ブックマークリストの開始を示すシンボル
  ADDBOOKMARK_END_LIST_SYMBOL       - ブックマークリストの終了を示すシンボル
  ADDBOOKMARK_SECTION_TEMPLATE      - ブックマークセクションのテンプレート
  ADDBOOKMARK_ITEM_TEMPLATE         - ブックマークアイテムのテンプレート
GETOPTIONSHERE
}
# Generated by getoptions (END)
# @end

parse ${@+"${@}"}
eval "set -- ${REST}"

htmlTemplate=$(
	cat <<-'__EOF__'
	<!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml" lang="" xml:lang="">
		<head>
			<meta charset="UTF-8" />
			<meta name="generator" content="addbookmark.sh" />
			<meta name="referrer" content="no-referrer" />
			<meta name="robots" content="noindex,nofollow,noarchive" />
			<title>Bookmark</title>
			<link rel="profile" href="http://microformats.org/profile/xoxo" />
		</head>
		<body>
			<main id="main">
				<!-- Do not delete the "*** ~~~ ***" comment. -->
				<ul class="xoxo">
				<!-- *** BEGIN-BOOKMARK-SECTION *** -->
				<!-- *** END-BOOKMARK-SECTION *** -->
				</ul>
			</main>
		</body>
	</html>
	__EOF__
)
awkFunctionScript=$(
	cat <<-'__EOF__'
	### Function: getline_exec
	##
	## コマンドの実行結果を取得する。
	##
	## Parameters:
	##
	##   string - 引数となる文字列。
	##   result - 結果を代入する変数。

	function getline_exec(command, result,  tmpvar,i) {
		split("", result)

		result["stdout"] = ""
		command = sprintf("(\n%s\n)\n%s", command, "printf '%3d' \"${?}\"")

		for(i = 1; 0 < (command | getline tmpvar); i++) {
			result["stdout"] = result["stdout"] (i == 1 ? "" : "\n") tmpvar
		}

		close(command)

		result["status"] = substr(result["stdout"], length(result["stdout"]) - 2)
		gsub(/ /, "", result["status"])

		result["stdout"] = substr(result["stdout"], 1, length(result["stdout"]) - 3)
	}

	### Function: shell_argument
	##
	## 安全な Shell Script 用の引数を生成する。
	##
	## Parameters:
	##
	##   string - 引数となる文字列。
	##
	## Returns:
	##
	##   Shell Script 用の引数。

	function shell_argument(string) {
		gsub(/'+/, "'\"&\"'", string)

		return "'" string "'"
	}

	### Function: shell_heredoc
	##
	## ヒアドキュメントを展開し結果を取得する。
	##
	## Parameters:
	##
	##   heredoc - ヒアドキュメント。
	##   variables - 変数の配列。
	##   command - 呼び出しコマンド。
	##
	## Returns:
	##
	##   ヒアドキュメントを展開した文字列。

	function shell_heredoc(heredoc, variables, command, varargs,name,delimiter,result) {
		varargs = ""

		if(command == "") {
			command = "cat"
		}

		for(name in variables) {
			varargs = varargs sprintf(" %s=%s;", name, shell_argument(variables[name]))
		}

		do {
			delimiter = "SHELL_HERE_DOCUMENT_DELIMITER_" rand()
		} while(index(heredoc, delimiter))

		getline_exec(sprintf("%s %s <<%s\n%s\n%s", varargs, command, delimiter, heredoc, delimiter), result)

		return result["stdout"]
	}
	__EOF__
)
awkAddSectionScript=$(
	cat <<-'__EOF__'
	BEGIN {
		section_flag = 0
		variables["feed_title"] = feed_title
	}

	{
		recode = $0

		if(recode == ENVIRON["ADDBOOKMARK_BEGIN_SECTION_SYMBOL"]) {
			section_flag = 1
		} else if(!section_flag && recode == ENVIRON["ADDBOOKMARK_END_BOOKMARK_SYMBOL"]) {
			printf("%s\n%s%s\n", ENVIRON["ADDBOOKMARK_BEGIN_SECTION_SYMBOL"], shell_heredoc(ENVIRON["ADDBOOKMARK_SECTION_TEMPLATE"], variables), ENVIRON["ADDBOOKMARK_END_SECTION_SYMBOL"])
		}

		printf("%s\n", recode)
	}
	__EOF__
)
awkAddItemScript=$(
	cat <<-'__EOF__'
	BEGIN {
		section_flag = 0
		list_flag = 0

		variables["uri"] = uri
		variables["title"] = title
		variables["description"] = description
		variables["feed_title"] = feed_title

		item = ENVIRON["ADDBOOKMARK_BEGIN_ITEM_SYMBOL"] "\n" shell_heredoc(ENVIRON["ADDBOOKMARK_ITEM_TEMPLATE"], variables) ENVIRON["ADDBOOKMARK_END_ITEM_SYMBOL"]
	}

	{
		recode = $0

		if(recode == ENVIRON["ADDBOOKMARK_BEGIN_ITEM_SYMBOL"] && !duplicate_flag) {
			while((0 < (getline recode)) && (recode != ENVIRON["ADDBOOKMARK_END_ITEM_SYMBOL"])) {}

			next
		}

		if(recode == ENVIRON["ADDBOOKMARK_BEGIN_SECTION_SYMBOL"] && !section_flag) {
			section_flag = 1
		} else if(recode == ENVIRON["ADDBOOKMARK_BEGIN_LIST_SYMBOL"] && section_flag && !list_flag) {
			list_flag = 1

			if(position == "top") {
				recode = recode "\n" item
			}
		} else if(recode == ENVIRON["ADDBOOKMARK_END_LIST_SYMBOL"] && list_flag) {
			list_flag = 0

			if(position == "bottom") {
				recode = item "\n" recode
			}
		} else if(recode == ENVIRON["ADDBOOKMARK_END_SECTION_SYMBOL"] && !list_flag && section_flag) {
			section_flag = 0
		}

		printf("%s\n", recode)
	}
	__EOF__
)
awkRemoveSectionScript=$(
	cat <<-'__EOF__'
	BEGIN {
		section_flag = 0
		list_flag = 0
		nonempty_flag = 0
	}

	{
		recode = $0

		if(section_flag) {
			if(recode == ENVIRON["ADDBOOKMARK_END_SECTION_SYMBOL"]) {
				section_flag = 0

				if(nonempty_flag) {
					printf("%s\n", output recode)
				}

				nonempty_flag = 0
			} else if(recode == ENVIRON["ADDBOOKMARK_BEGIN_LIST_SYMBOL"]) {
				output = output recode "\n"

				while(0 < (getline recode)) {
					output = output recode "\n"

					if(recode == ENVIRON["ADDBOOKMARK_END_LIST_SYMBOL"]) {
						break
					} else if(recode !~ /^[\t ]*$/) {
						nonempty_flag = 1
					}
				}
			} else {
				output = output recode "\n"
			}
		} else {
			if(recode == ENVIRON["ADDBOOKMARK_BEGIN_SECTION_SYMBOL"]) {
				section_flag = 1

				output = recode "\n"
			} else {
				printf("%s\n", recode)
			}
		}
	}
	__EOF__
)
tmpDir=$(mktemp -d)
tmpFile="${tmpDir}/file"

if [ -d "${bookmarkFile}" ]; then
	printf "'%s' is directory.\\n" "${bookmarkFile}" >&2

	end_call "${EX_CANTCREAT}"
elif [ '!' -e "${bookmarkFile}" ]; then
	bookmarkDir=$(dirname -- "${bookmarkFile}"; printf '_')
	mkdir -p -- "${bookmarkDir%?_}"

	: >"${bookmarkFile}"
fi

if [ '!' -s "${bookmarkFile}" ]; then
	printf '%s' "${htmlTemplate}" >"${bookmarkFile}"
fi

case "${#}" in '0')
	sh -c "${VISUAL:-${EDITOR:-vi --}} \"\${1}\"" 'sh' "${bookmarkFile}"

	exit
	;;
esac

safe_string 'uri' "${1}"
safe_string 'title' "${2:-${1}}"
safe_string 'description' "${3-}"
safe_string 'feedTitle' "${4:-Unsorted Bookmarks}"

html_escape 'uri' "${uri}"
html_escape 'title' "${title}"
html_escape 'description' "${description}"
html_escape 'feedTitle' "${feedTitle}"

comment_escape 'commentURI' "${uri}"
comment_escape 'commentFeedTitle' "${feedTitle}"

: ${ADDBOOKMARK_BEGIN_BOOKMARK_SYMBOL:='<!-- *** BEGIN-BOOKMARK-SECTION *** -->'}
: ${ADDBOOKMARK_END_BOOKMARK_SYMBOL:='<!-- *** END-BOOKMARK-SECTION *** -->'}
: ${ADDBOOKMARK_SECTION_TEMPLATE:="$(printf '<li>${feed_title}\n<ul>\n${ADDBOOKMARK_BEGIN_LIST_SYMBOL}\n${ADDBOOKMARK_END_LIST_SYMBOL}\n</ul>\n</li>')"}
: ${ADDBOOKMARK_ITEM_TEMPLATE:='<li><a rel="noreferrer" href="${uri}"${description:+" title=\"${description}\""}>${title}</a></li>'}

ADDBOOKMARK_BEGIN_SECTION_SYMBOL=$(printf "${ADDBOOKMARK_BEGIN_SECTION_SYMBOL:-<!-- *** BEGIN-SECTION: \"%s\" *** -->}" "${commentFeedTitle}")
ADDBOOKMARK_END_SECTION_SYMBOL=$(printf "${ADDBOOKMARK_END_SECTION_SYMBOL:-<!-- *** END-SECTION *** -->}" "${commentFeedTitle}")
ADDBOOKMARK_BEGIN_LIST_SYMBOL=$(printf "${ADDBOOKMARK_BEGIN_LIST_SYMBOL:-<!-- *** BEGIN-LIST *** -->}" "${commentFeedTitle}")
ADDBOOKMARK_END_LIST_SYMBOL=$(printf "${ADDBOOKMARK_END_LIST_SYMBOL:-<!-- *** END-LIST *** -->}" "${commentFeedTitle}")
ADDBOOKMARK_BEGIN_ITEM_SYMBOL=$(printf "${ADDBOOKMARK_BEGIN_ITEM_SYMBOL:-<!-- *** BEGIN-ITEM: \"%s\" *** -->}" "${commentURI}")
ADDBOOKMARK_END_ITEM_SYMBOL=$(printf "${ADDBOOKMARK_END_ITEM_SYMBOL:-<!-- *** END-ITEM *** -->}" "${commentURI}")

export \
	'ADDBOOKMARK_BEGIN_BOOKMARK_SYMBOL' 'ADDBOOKMARK_END_BOOKMARK_SYMBOL' \
	'ADDBOOKMARK_BEGIN_SECTION_SYMBOL' 'ADDBOOKMARK_END_SECTION_SYMBOL' \
	'ADDBOOKMARK_BEGIN_LIST_SYMBOL' 'ADDBOOKMARK_END_LIST_SYMBOL' \
	'ADDBOOKMARK_BEGIN_ITEM_SYMBOL' 'ADDBOOKMARK_END_ITEM_SYMBOL' \
	'ADDBOOKMARK_SECTION_TEMPLATE' 'ADDBOOKMARK_ITEM_TEMPLATE'

awkv_escape 'uri' "${uri}"
awkv_escape 'title' "${title}"
awkv_escape 'description' "${description}"
awkv_escape 'feedTitle' "${feedTitle}"

case "${position}" in
	'none') cat -- "${bookmarkFile}";;
	*) awk -v "feed_title=${feedTitle}" -- "${awkFunctionScript}${awkAddSectionScript}" "${bookmarkFile}";;
esac | awk \
	-v "uri=${uri}" \
	-v "title=${title}"  \
	-v "description=${description}" \
	-v "feed_title=${feedTitle}" \
	-v "position=${position}" \
	-v "duplicate_flag=${duplicateFlag}" \
	-v "empty_section_flag=${emptySectionFlag}" \
	-- "${awkFunctionScript}${awkAddItemScript}" \
| case "${emptySectionFlag}" in
	'1') cat;;
	*) awk -- "${awkRemoveSectionScript}";;
esac >"${tmpFile}"

cat -- "${tmpFile}" >"${bookmarkFile}"
