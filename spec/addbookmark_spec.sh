#!/usr/bin/env sh

### Script: addbookmark_spec.sh
##
## addbookmark.sh のテスト。
##
## Usage:
##
## ------ Text ------
## shellspec addbookmark_spec.sh
## ------------------
##
## Metadata:
##
##   id - ba85c9ec-3d7d-4d38-985d-cb2d206cff3b
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 0.1.0
##   date - 2022-12-09
##   since - 2022-12-06
##   copyright - Copyright (C) 2022 qq542vev. Some rights reserved.
##   license - <CC-BY at https://creativecommons.org/licenses/by/4.0/>
##   package - vim-style-newsboat
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/vim-style-newsboat>
##   * <Bug report at https://github.com/qq542vev/vim-style-newsboat/issues>

eval "$(shellspec - -c) exit 1"

Describe 'addbookmark.sh の検証'
	bookmark() {
		./bin/addbookmark.sh ${@+"${@}"}
	}

	Describe '各種オプションの検証'
		Parameters:block
			'-h'    '1' ''  '0'
			'-v'    '1' ''  '0'
			'--nil' ''  '1' '64'
			'-f' ''  '1' '64'
			'-p' ''  '1' '64'
		End

		Example "addbookmark.sh ${1}"
			When call bookmark ${1}
			The length of stdout should ${2:+'not'} eq 0
			The length of stderr should ${3:+'not'} eq 0
			The status should eq "${4}"
		End
	End

	Describe 'ブックマークの編集'
		add_bookmark() {
			bookmark -f "${bookmark}" 'http://www.example.com/t1'
			bookmark -f "${bookmark}" 'http://www.example.com/t1'
			bookmark -f "${bookmark}" "escape:&'--/t2"
			bookmark -f "${bookmark}" 'http://www.example.com/t3' "title text &<>'" "description text &<>'"
			bookmark -f "${bookmark}" 'about:t4' '' '' "New--Section${SHELLSPEC_LF}"
			bookmark -f "${bookmark}" -p 'bottom' 'about:t5' '' '' "New--Section${SHELLSPEC_LF}"
			bookmark -f "${bookmark}" -p 'top' 'about:t6' '' '' "New--Section${SHELLSPEC_LF}"
			bookmark -f "${bookmark}" -d 'http://www.example.com/t1' '' '' 'Move'
		}

		del_bookmark() {
			bookmark -f "${bookmark}" -p 'none' 'http://www.example.com/t1'
			bookmark -f "${bookmark}" -p 'none' '' '' '' 'Move'
			bookmark -f "${bookmark}" -p 'none' 'about:t6' '' '' "New--Section${SHELLSPEC_LF}"
			bookmark -f "${bookmark}" -p 'none' 'about:t5' '' '' "New--Section${SHELLSPEC_LF}"
			bookmark -f "${bookmark}" -p 'none' 'about:t4' '' '' "New--Section${SHELLSPEC_LF}"
		}

		setup() {
			bookmark='./spec/tmp/bookmark.html'
			bookmarkDir='./spec/bookmark'

			mkdir -p -- './spec/tmp'
		}

		cleanup() {
			rm -rf -- './spec/tmp'
		}

		BeforeAll 'setup'
		AfterAll 'cleanup'

		Example 'ブックマーク追加の検証'
			When call add_bookmark
			The status should eq 0
			Assert diff -- "${bookmark}" "${bookmarkDir}/success1.html"
		End

		Example 'ブックマーク削除の検証'
			When call del_bookmark
			The status should eq 0
			Assert diff -- "${bookmark}" "${bookmarkDir}/success2.html"
		End
	End
End
