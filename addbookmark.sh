#!/usr/bin/env sh

## File: addbookmark.sh
##
## Add a bookmark.
##
## Usage:
##
##   (start code)
##   addbookmark.sh [options...] uri title [description] [feedTitle]
##   (end)
##
## Options:
##
##   -d, --{no-}duplicate - allow duplicates.
##   -f, --file           - bookmark file.
##   -t, --template       - template for bookmark.
##   -h, --help           - display this help and exit.
##   -v, --version        - output version information and exit.
##
## Exit Status:
##
##   0 - Program terminated normally.
##   64<= and <=78 - Program terminated abnormally. See </usr/include/sysexits.h> for the returned value.
##
## Metadata:
##
##   author - qq542vev <https://purl.org/meta/me/>
##   version - 1.0.0
##   date - 2021-09-13
##   since - 2021-09-09
##   copyright - Copyright (C) 2021 qq542vev. Some rights reserved.
##   license - CC-BY <https://creativecommons.org/licenses/by/4.0/>
##   package - vim-style-newsboat
##
## See Also:
##
##   * Project homepage - <https://github.com/qq542vev/vim-style-newsboat>
##   * Bag report - <https://github.com/qq542vev/vim-style-newsboat/issues>

set -efu
umask '0022'
IFS=$(printf ' \t\n$'); IFS="${IFS%$}"
export 'IFS'

trap 'endCall ${EXIT_STATUS+"${EXIT_STATUS}"}' 0 # EXIT
trap 'endCall 129' 1 # SIGHUP
trap 'endCall 130' 2 # SIGINT
trap 'endCall 131' 3 # SIGQUIT
trap 'endCall 143' 15 # SIGTERM

endCall() {
	previousExitStatus="${?}"

	rm -f -- ${tmpFile+"${tmpFile}"}

	if [ -n "${1-}" ]; then
		exit "${1}"
	elif [ "${previousExitStatus}" -ne '0' ]; then
		exit '70'
	fi

	exit '0'
}

htmlEscape() {
	sed -e 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
}

sedEscape() {
	sed -e 's/[].\*/[]/\\&/g; 1s/^^/\\^/; $s/$$/\\$/'
}

usage() {
	sed -e '/^## *(start code)/,/^## *(end)/!d' -- "${0}" | sed -e '1d; $d; s/^## */Usage: /'
	sed -e '/^## File:/,/^## .*:$/!d' -- "${0}" | sed -e '1d; $d; s/^## *//'

	printf 'Options\n'
	sed -n -e '/^## *-.* - /s/^## *//p' -- "${0}" | awk -F ' - ' '{print "  " $1 "  " $2}'

	printf '\nExit status\n'
	sed -n -e '/^## *[0-9]\{1,\}.* - /s/^## */  /p' -- "${0}"
}

version() {
	cat <<- EOF
		$(sed -n -e 's/^## File: //p' -- "${0}") ($(sed -n -e 's/^## *package - //p' -- "${0}")) $(sed -n -e 's/^## *version - //p' -- "${0}") (Last update: $(sed -n -e 's/^## *date - //p' -- "${0}"))
		$(sed -n -e 's/^## *copyright - //p' -- "${0}")
		License: $(sed -n -e 's/^## *license - //p' -- "${0}")
		Author: $(sed -n -e 's/^## *author - //p' -- "${0}")
	EOF
}

error() {
	printf '%s\n' "${1}"
	EXIT_STATUS='64'
	return '64'
}

# @getoptions
parser_definition() {
	setup REST plus:true abbr:true error:error
	flag  duplicate    -d --{no-}duplicate init:@no no:0
	param bookmarkFile -f --file           init:'bookmarkFile="${HOME}/bookmark.html"'
	param itemTemplate -t --template       init:='<li><a href="${uri}">${title}</a>${description:+"<p>${description}</p>"}</li>'
	disp  :usage       -h --help
	disp  :version     -v --version
}
# @end

# @gengetoptions parser -i parser_definition parse
# Generated by getoptions (BEGIN)
# URL: URL (VERSION)
duplicate='0'
bookmarkFile="${HOME}/bookmark.html"
itemTemplate='<li><a href="${uri}">${title}</a>${description:+"<p>${description}</p>"}</li>'
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
      case '--file' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --file"
      esac
      case '--template' in
        "$1") OPTARG=; break ;;
        $1*) OPTARG="$OPTARG --template"
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
        error "$@" >&2 || exit $?
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
      -[ft]?*) OPTARG=$1; shift
        eval 'set -- "${OPTARG%"${OPTARG#??}"}" "${OPTARG#??}"' ${1+'"$@"'}
        ;;
      -[dhv]?*) OPTARG=$1; shift
        eval 'set -- "${OPTARG%"${OPTARG#??}"}" -"${OPTARG#??}"' ${1+'"$@"'}
        OPTARG= ;;
      +*) unset OPTARG ;;
    esac
    case $1 in
      '-d'|'--duplicate'|'--no-duplicate')
        [ "${OPTARG:-}" ] && OPTARG=${OPTARG#*\=} && set "noarg" "$1" && break
        eval '[ ${OPTARG+x} ] &&:' && OPTARG='1' || OPTARG='0'
        duplicate="$OPTARG"
        ;;
      '-f'|'--file')
        [ $# -le 1 ] && set "required" "$1" && break
        OPTARG=$2
        bookmarkFile="$OPTARG"
        shift ;;
      '-t'|'--template')
        [ $# -le 1 ] && set "required" "$1" && break
        OPTARG=$2
        itemTemplate="$OPTARG"
        shift ;;
      '-h'|'--help')
        usage
        exit 0 ;;
      '-v'|'--version')
        version
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
  error "$@" >&2 || exit $?
  echo "$1" >&2
  exit 1
}
# Generated by getoptions (END)
# @end

parse ${@+"${@}"}
eval "set -- ${REST}"

case "${#}" in
	'0') error 'Requires an argument: uri and title' || exit "${?}";;
	'1') error 'Requires an argument: title' || exit "${?}";;
esac

htmlTemplate=$(cat <<- 'EOF'
	<!DOCTYPE html>
	<html
		xmlns="http://www.w3.org/1999/xhtml"
		lang=""
		xml:lang=""
		about=""
		typeof="foaf:Document"
	>
		<head>
			<meta charset="UTF-8" />
			<meta name="generator" content="addbookmark.sh" />
			<meta name="referrer" content="no-referrer" />
			<meta name="robots" content="noindex,nofollow,noarchive" />
			<title property="dcterms:title">Bookmark</title>
		</head>
		<body>
			<main id="main" rel="schema:mainContentOfPage" resource="#main">
				<ul>
					<!-- Add Bookmark Section -->
				</ul>
			</main>
		</body>
	</html>
	EOF
)

tmpFile=$(mktemp)
uri=$(printf '%s' "${1}" | htmlEscape)
title=$(printf '%s' "${2}" | htmlEscape)
description=$(printf '%s' "${3-}" | htmlEscape)
feedTitle=$(printf '%s' "${4-}" | htmlEscape)
item=$(eval "cat << 83bpgibEzYgMijIjB5fJAMNdzN9EGv7m
${itemTemplate}
83bpgibEzYgMijIjB5fJAMNdzN9EGv7m"
)

if [ ! -e "${bookmarkFile}" ] || [ ! -s "${bookmarkFile}" ]; then
	printf '%s' "${htmlTemplate}" >"${bookmarkFile}"
fi

expression="/<!-- Add Bookmark Section -->/a ${item}"
if [ "${duplicate}" -eq '0' ]; then
	expression="/$(printf '%s' "${item}" | sedEscape)/d; ${expression}"
fi

sed -e "${expression}" -- "${bookmarkFile}" >"${tmpFile}"
mv -f -- "${tmpFile}" "${bookmarkFile}"
