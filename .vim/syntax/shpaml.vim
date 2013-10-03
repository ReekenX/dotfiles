" Vim syntax file
" Language:	Haml
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Filenames:	*.haml
" Last Change:	2010 Aug 09

unlet b:current_syntax

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'haml'
endif

runtime! syntax/html.vim
unlet! b:current_syntax
silent! syn include @hamlSassTop syntax/sass.vim

syn case match

syn cluster hamlComponent    contains=hamlAttributes,hamlAttributesHash,hamlClassChar,hamlIdChar,hamlObject,hamlDespacer,hamlSelfCloser,hamlPlainChar,hamlInterpolatable

syn cluster hamlTop          contains=hamlBegin,hamlPlainFilter,hamlSassFilter,hamlComment,hamlHtmlComment

syn match   hamlBegin "^\s*\%([<]\|&[^=~ ]\)\@!" nextgroup=hamlTag,hamlClassChar,hamlIdChar,hamlPlainChar,hamlInterpolatable

syn match   hamlTag "[>]\{,1\} *\w\+\%(:\w\+\)\=" contained contains=htmlTagName,htmlSpecialTagName nextgroup=hamlAttributes,@hamlComponent

syn region  hamlAttributes     matchgroup=hamlAttributesDelimiter start=" " end="\([|>]\|$\)"he=s-1 contained contains=htmlArg,hamlAttributeString,hamlAttributeVariable,htmlEvent,htmlCssDefinition nextgroup=hamlTag ",@hamlComponent
"syn region  hamlAttributesHash matchgroup=hamlAttributesDelimiter start="{" end="}" contained nextgroup=@hamlComponent
"syn region  hamlObject         matchgroup=hamlObjectDelimiter     start="\[" end="\]" contained nextgroup=@hamlComponent

syn match   hamlDespacer "[<>]" contained nextgroup=hamlDespacer,hamlSelfCloser,hamlPlainChar,hamlInterpolatable
syn match   hamlSelfCloser "/" contained
syn match   hamlClassChar "\." contained nextgroup=hamlClass
syn match   hamlIdChar "#{\@!" contained nextgroup=hamlId
syn match   hamlClass "\%(\w\|-\)\+" contained nextgroup=@hamlComponent
syn match   hamlId    "\%(\w\|-\)\+" contained nextgroup=@hamlComponent
syn region  hamlDocType start="^\s*!!!" end="$"

syn match   hamlPlainChar "\\" contained

syn region  hamlAttributeString start=+\%(=\s*\)\@<='+ skip=+\%(\\\\\)*\\'+ end=+'+ contains=hamlInterpolation,hamlInterpolationEscape
syn region  hamlAttributeString start=+\%(=\s*\)\@<="+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=hamlInterpolation,hamlInterpolationEscape
syn match   hamlAttributeVariable "\%(=\s*\)\@<=\%(@@\=\|\$\)\=\w\+" contained

syn cluster hamlHtmlTop contains=@htmlTop,htmlBold,htmlItalic,htmlUnderline

syn region  hamlJavascriptBlock start="^\z(\s*\)script" nextgroup=@hamlComponent,hamlError end="^\%(\z1 \| *$\)\@!" contains=@hamlTop,@htmlJavaScript keepend
syn region  hamlCssBlock        start="^\z(\s*\)style" nextgroup=@hamlComponent,hamlError  end="^\%(\z1 \| *$\)\@!" contains=@hamlTop,@htmlCss keepend
syn match   hamlError "\$" contained

syn region  hamlHtmlComment start="^\z(\s*\)/"  end="^\%(\z1 \| *$\)\@!" contains=@hamlTop
syn match   hamlIEConditional "\%(^\s*/\)\@<=\[if\>[^]]*]" contained containedin=hamlHtmlComment

hi def link hamlSelfCloser             Special
hi def link hamlDespacer               Special
hi def link hamlClassChar              Special
hi def link hamlIdChar                 Special
hi def link hamlTag                    Special
hi def link hamlClass                  Type
hi def link hamlId                     Identifier
hi def link hamlPlainChar              Special
hi def link hamlInterpolationDelimiter Delimiter
hi def link hamlInterpolationEscape    Special
hi def link hamlAttributeString        String
hi def link hamlAttributeVariable      Identifier
hi def link hamlDocType                PreProc
hi def link hamlFilter                 PreProc
hi def link hamlAttributesDelimiter    Delimiter
hi def link hamlObjectDelimiter        Delimiter
hi def link hamlHelper                 Function
hi def link hamlHtmlComment            hamlComment
hi def link hamlComment                Comment
hi def link hamlIEConditional          SpecialComment
hi def link hamlError                  Error

let b:current_syntax = "haml"

if main_syntax == "haml"
  unlet main_syntax
endif

" vim:set sw=2:
