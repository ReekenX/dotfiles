"Vim plugin for aligning text
"Version:			1.1
"Last Change:		Oct 17, 2010
"Author:			Daniel Schemala
"Report bugs to:	sehrpositiv@web.de
"Usage:				type :Tabbi for aligning the text, a range before the command and visual mode are supported

if exists("loaded_tabbi")
	finish
endif
let loaded_tabbi=1

command! -range Tabbi call s:Tabbi(<line1>, <line2>)

function! s:Tabbi(line1, line2) range
	let s:liste = []
	let s:ersteZ = a:line1 
    let s:letzteZ = a:line2
	if s:letzteZ <= s:ersteZ
		let s:ersteZ = 1
		let s:letzteZ = line("$")
	endif
    for s:zeile in getline(s:ersteZ, s:letzteZ)
		let s:wa = -1
		let s:we = -1
		let s:tabsp = 0
		while 1
			let s:wa = s:we==-1 ? 0 : match(s:zeile, '\s\S', s:we+1)
			if s:wa==-1
				break
			endif
			let s:wa = match(s:zeile, '\S', s:wa)
			if s:wa==-1
				break
			endif
			let s:we = match(s:zeile, '\S\(\s\s\|\t\|\s*$\)', s:wa)
			if s:tabsp >= len(s:liste)
				call add(s:liste, s:we-s:wa+1)
			else
				let s:liste[s:tabsp] = max([s:liste[s:tabsp], s:we-s:wa+1])
			endif
			let s:tabsp += 1
		endwhile
	endfor

	if &expandtab
		call s:TabbiS(s:ersteZ, s:letzteZ)
	else
		call s:TabbiT(s:ersteZ, s:letzteZ)
	endif
endfunction

function! s:TabbiT(ersteZ, letzteZ)
	for s:zn in range(a:ersteZ, a:letzteZ)
		let s:zeile = getline(s:zn)
		let s:wa = -1
		let s:we = -1
		let s:neuzei = ""
		for s:li in s:liste
			let s:wa = s:we==-1 ? 0 : match(s:zeile, '\s\S', s:we+1)
			if s:wa==-1
				break
			endi 
			let s:wa = match(s:zeile, '\S', s:wa)
			let s:we = match(s:zeile, '\S\(\s\s\|\t\|\s*$\)', s:wa)
			let s:mb = (s:li % &ts)==&ts-1 ? s:li+&ts+1 : s:li+&ts-(s:li % &ts)
			let s:wb = s:we-s:wa+1
			let s:at = ((s:wb%&ts)==0 ? 0 : 1) + (s:mb-s:wb)/&ts
			let s:neuzei = s:neuzei.strpart(s:zeile, s:wa, s:wb).repeat("\t", s:at) 
		endfor
		let s:neuzei = substitute(s:neuzei, "\t*$", "", "g")
		call setline(s:zn, s:neuzei)
	endfor
endfunction

function! s:TabbiS(ersteZ, letzteZ)
	for s:zn in range(a:ersteZ, a:letzteZ)
		let s:zeile = getline(s:zn)
		let s:wa = -1
		let s:we = -1
		let s:neuzei = ""
		for s:li in s:liste
			let s:wa = s:we==-1 ? 0 : match(s:zeile, '\s\S', s:we+1)
			if s:wa==-1
				break
			endif
			let s:wa = match(s:zeile, '\S', s:wa)
			let s:we = match(s:zeile, '\S\(\s\s\|\t\|\s*$\)', s:wa)
			let s:mb = (s:li % &ts)==&ts-1 ? s:li+&ts+1 : s:li+&ts-(s:li % &ts)
			let s:wb = s:we-s:wa+1
			let s:neuzei = s:neuzei.strpart(s:zeile, s:wa, s:wb)
			let s:neuzei = s:neuzei.repeat(" ", s:mb-s:wb) 
		endfor
		let s:neuzei = substitute(s:neuzei, '\s*$', "", "g")
		call setline(s:zn, s:neuzei)
	endfor
endfunction
