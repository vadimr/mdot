if exists("b:current_syntax")
  finish
endif

" https://gist.github.com/tobym/584909
" [^>] at the end to avoid matchin at "com>" when doing a ref
syn match orgUrl      "https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\(\S|[^>]\)*" display

syn match orgRef "<.*^.*>" contains=orgRefTitle,orgRefOpen,orgRefUrl display
syn match orgRefOpen "<\s*" conceal contained display
syn match orgRefUrl "\s*^.*>" conceal contained contains=orgUrl display

syn match orgDelim "^\s*\$" display
" syn match orgDate       ".*$"       display contained

syn match orgTodo       "\[\s\?\]" display
syn match orgTodoDone   "\[x\]"     display

syn match orgComment    "#.*"       display contains=orgRef
" syn match orgTag        "#\w.*"     display

syn region orgTab start="|-" end="-|" fold transparent contains=orgTabDelim
syn match orgTabDelim "|-\+\(+-\+\)\+|"
syn match orgTabDelim "\(^\| \)|\( \|$\)"

syn match orgBullet "^\s*-\s"      display
syn match orgSep "^\s*---*\s*$"     display

syn match orgCodeOneLine   "`.*`"   display
syn match orgCodeMultiLine ".*"     display contained
syn region orgCodeMultiLine matchgroup=orgCodeMultiLineDelim start="```" end="```" contains=orgCodeMultiLine

syn match orgColRed "(r\.\_.\{-}\.r)" display contains=orgColRedStart,orgColRedEnd
syn match orgColRedStart "(r\." conceal contained display
syn match orgColRedEnd "\.r)" conceal contained display

syn match orgColGreen "(g\.\_.\{-}\.g)" display contains=orgColGreenStart,orgColGreenEnd
syn match orgColGreenStart "(g\." conceal contained display
syn match orgColGreenEnd "\.g)" conceal contained display

syn match orgColBlue "(b\.\_.\{-}\.b)" display contains=orgColBlueStart,orgColBlueEnd
syn match orgColBlueStart "(b\." conceal contained display
syn match orgColBlueEnd "\.b)" conceal contained display

syn match orgColYellow "(y\.\_.\{-}\.y)" display contains=orgColYellowStart,orgColYellowEnd
syn match orgColYellowStart "(y\." conceal contained display
syn match orgColYellowEnd "\.y)" conceal contained display

syn match orgColGrey "(gr\.\_.\{-}\.gr)" display contains=orgColGreyStart,orgColGreyEnd
syn match orgColGreyStart "(gr\." conceal contained display
syn match orgColGreyEnd "\.gr)" conceal contained display

syn match orgColCyan "(c\.\_.\{-}\.c)" display contains=orgColCyanStart,orgColCyanEnd
syn match orgColCyanStart "(c\." conceal contained display
syn match orgColCyanEnd "\.c)" conceal contained display

syn match orgColMagenta "(m\.\_.\{-}\.m)" display contains=orgColMagentaStart,orgColMagentaEnd
syn match orgColMagentaStart "(m\." conceal contained display
syn match orgColMagentaEnd "\.m)" conceal contained display

syn match orgColWhite "(w\.\_.\{-}\.w)" display contains=orgColWhiteStart,orgColWhiteEnd
syn match orgColWhiteStart "(w\." conceal contained display
syn match orgColWhiteEnd "\.w)" conceal contained display

syn match orgColBrown "(br\.\_.\{-}\.br)" display contains=orgColBrownStart,orgColBrownEnd
syn match orgColBrownStart "(br\." conceal contained display
syn match orgColBrownEnd "\.br)" conceal contained display

hi orgDelim              ctermfg=brown
" hi orgDate               ctermfg=darkblue
hi orgTodo               ctermfg=red
hi orgTodoDone           ctermfg=darkgray
hi orgTabDelim           ctermfg=darkgray
hi orgUrl                ctermfg=darkcyan

hi orgRef                ctermfg=cyan
hi orgRefOpen            ctermfg=darkgray
hi orgRefUrl             ctermfg=darkgray

hi orgCodeOneLine        ctermfg=red
hi orgCodeMultiLine      ctermfg=red
hi orgCodeMultiLineDelim ctermfg=darkgray
hi orgComment            ctermfg=darkgray
" hi orgTag                ctermfg=blue
hi orgBullet             ctermfg=darkgray
hi orgSep                ctermfg=blue

hi orgColRed             ctermfg=red
hi orgColGreen           ctermfg=green
hi orgColBlue            ctermfg=blue
hi orgColYellow          ctermfg=yellow
hi orgColGrey            ctermfg=darkgray
hi orgColCyan            ctermfg=cyan
hi orgColMagenta         ctermfg=magenta
hi orgColWhite       ctermfg=white
hi orgColBrown       ctermfg=brown

syn include @PY syntax/python.vim
syn region orgRuby matchgroup=orgSnip start="```py" end="```" contains=@PY
hi orgSnip ctermfg=darkgray

let b:current_syntax = "org"

setlocal conceallevel=2
hi Conceal guifg=#ff0000 guibg=#00ff00
