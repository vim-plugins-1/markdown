

if version < 508
	command! -nargs=+ HtmlHiLink hi link <args>
else
	command! -nargs=+ HtmlHiLink hi def link <args>
endif
	
syn region htmlItalic start="\\\@<!\*\S\@=" end="\S\@<=\\\@<!\*" keepend oneline
syn region htmlItalic start="\(^\|\s\)\@<=_\|\\\@<!_\([^_]\+\s\)\@=" end="\S\@<=_\|_\S\@=" keepend oneline
syn region htmlBold start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" keepend oneline
syn region htmlBold start="\S\@<=__\|__\S\@=" end="\S\@<=__\|__\S\@=" keepend oneline
syn region htmlBoldItalic start="\S\@<=\*\*\*\|\*\*\*\S\@=" end="\S\@<=\*\*\*\|\*\*\*\S\@=" keepend oneline
syn region htmlBoldItalic start="\S\@<=___\|___\S\@=" end="\S\@<=___\|___\S\@=" keepend oneline

" [link](URL) | [link][id] | [link][]
syn region mkdFootnotes matchgroup=mkdDelimiter start="\[^"      end="\]"
syn region mkdID        matchgroup=mkdDelimiter start="\["       end="\]" contained oneline
syn region mkdURL       matchgroup=mkdDelimiter start="("        end=")"  contained oneline
syn region mkdLink      matchgroup=mkdDelimiter start="\\\@<!\[" end="\]\ze\s*[[(]" contains=@Spell nextgroup=mkdURL,mkdID skipwhite oneline
syn match  mkdInlineURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

syn region mkdLinkDef 		matchgroup=mkdDelimiter   	start="^ \{,3}\zs\[" end="]:" oneline nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkTitle 	matchgroup=mkdDelimiter 	start=+"+     end=+"+  contained
syn region mkdLinkTitle 	matchgroup=mkdDelimiter 	start=+'+     end=+'+  contained
syn region mkdLinkTitle 	matchgroup=mkdDelimiter 	start=+(+     end=+)+  contained
syn region mkdLinkDefTarget start="<\?\zs\S" excludenl end="\ze[>[:space:]\n]"   contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline

syn region mkdBlockquote   start=/^\s*>/                   end=/$/ contains=mkdLineBreak,mkdLineContinue,@Spell
syn region mkdCode         start=/\(\([^\\]\|^\)\\\)\@<!`/ end=/\(\([^\\]\|^\)\\\)\@<!`/
syn region mkdCode         start=/\s*``[^`]*/              end=/[^`]*``\s*/
syn region mkdCode         start=/^\s*```\s*[0-9A-Za-z_-]*\s*$/          end=/^\s*```\s*$/
syn region mkdCode         start=/^\s*\~\~\~\s*[0-9A-Za-z_-]*\s*$/       end=/^\s*\~\~\~\s*$/
syn region mkdCode         start="<pre[^>]*>"              end="</pre>"
syn region mkdCode         start="<code[^>]*>"             end="</code>"
syn region mkdFootnote     start="\[^"                     end="\]"
syn match  mkdCode         /^\s*\n\(\(\s\{8,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
syn match  mkdIndentCode   /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/ contained

syn region  mkdListItem     start="^\s*[-*+]\s\+" end="\n"
syn region  mkdListItem     start="^\s*\d\+\.\s\+" end="\n"

syn region htmlH1       start="^\s*#"                   end="\($\|#\+\)" contains=@Spell
syn region htmlH2       start="^\s*##"                  end="\($\|#\+\)" contains=@Spell
syn region htmlH3       start="^\s*###"                 end="\($\|#\+\)" contains=@Spell
syn region htmlH4       start="^\s*####"                end="\($\|#\+\)" contains=@Spell
syn region htmlH5       start="^\s*#####"               end="\($\|#\+\)" contains=@Spell
syn region htmlH6       start="^\s*######"              end="\($\|#\+\)" contains=@Spell
syn match  htmlH1       /^.\+\n=\+$/ contains=@Spell
syn match  htmlH2       /^.\+\n-\+$/ contains=@Spell

syn cluster mkdNonListItem contains=htmlItalic,htmlBold,htmlBoldItalic,mkdFootnotes,mkdID,mkdURL,mkdLink,mkdLinkDef,mkdLineBreak,mkdBlockquote,mkdCode,mkdIndentCode,mkdListItem,mkdRule,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6

HtmlHiLink mkdFootnote      Comment
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Todo
HtmlHiLink mkdFootnotes     htmlLink
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdInlineURL     htmlLink
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString

" Automatically insert bullets
setlocal formatoptions+=r
" Do not automatically insert bullets when auto-wrapping with text-width
setlocal formatoptions-=c
" Accept various markers as bullets
setlocal comments=b:*,b:+,b:-

let b:current_syntax = "mkd"

delcommand HtmlHiLink
" vim: ts=8

