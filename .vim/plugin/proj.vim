" ============================================================================
" File: proj.vim
" Description: Simple Vim project tool
" Maintainer: Thomas Allen <thomasmallen@gmail.com>
" ============================================================================
let s:ProjVersion = '1.5.1'

let s:auInit = 0

function! s:echo(msg)
  redraw
  echomsg 'Proj: ' . a:msg
endfunction

function! s:echoError(msg)
  echohl errormsg
  call s:echo(a:msg)
  echohl normal
endfunction

function! s:strip(text)
  let text = substitute(a:text, '^[[:space:][:cntrl:]]\+', '', '')
  let text = substitute(text, '[[:space:][:cntrl:]]\+$', '', '')
  return text
endfunction

function! s:GetFile()
  return expand(g:ProjFile)
endfunction

function! s:FileReadable()
  return filereadable(s:GetFile())
endfun

function! s:ReadFile(var)
  if(s:FileReadable())
    exec join(["let", a:var, "=", "readfile('" . s:GetFile() . "')"])
    return 1
  else
    return 0
  end
endfunction

function! s:ParseIni(ini)
  let parsed = {}

  for line in a:ini
    let line = s:strip(line)
    if strlen(line) > 0
      if match(line, '^\s*;') == 0
        continue
      elseif match(line, '[') == 0
        let header = split(line, ';')[0]
        let section = strpart(header, 1, strlen(line) - 2)
        let parsed[section] = {}

      else
        let optline = map(split(line, '='), 's:strip(v:val)')

        if len(optline) > 1
          let optval = split(optline[1], ';')[0]
        else
          let optval = 1
        end

        let parsed[section][optline[0]] = optval
      end
    end
  endfor

  return parsed
endfunction

function! s:LoadProjectsRaw()
  if(s:ReadFile('s:Config'))
    let g:Projects = s:ParseIni(s:Config)
  else
    let g:Projects = {}
  end
endfunction

function! s:LoadProjects()
  if(s:ReadFile('s:Config'))
    let g:Projects = s:ParseIni(s:Config)
  else
    exec s:echoError('Could not read project file "' . s:GetFile() . '"')
  end
endfunction

function! s:Valid(project)
  return type(a:project) == 4
endfunction

function! s:GetProject(name)
  if has_key(g:Projects, a:name) == 1 && type(g:Projects[a:name]) == 4
    exec join(['let', 's:Current', '=', 'g:Projects["' . a:name . '"]'], ' ')
    return 1
  else
    exec s:echoError('Project "' . a:name . '" not found in ' . s:GetFile())
    return 0
  end
endfunction

function! s:OpenProjectTab(name)
  let t:ProjCurrent = a:name
  let t:oldCwd = getcwd()
  call s:OpenProject(a:name, 1)
endfunction

function! s:OnTabEnter()
  if exists('t:ProjCurrent')
    let t:oldCwd = getcwd()
    call s:OpenProject(t:ProjCurrent, 0)
  end
endfunction

function! s:OnTabLeave()
  if exists('t:oldCwd')
    exec 'cd ' . t:oldCwd
  end
endfunction

function! s:OpenProject(name, rBrowser)
  if s:GetProject(a:name)
    call s:RefreshCurrent(a:rBrowser)
  end
endfunction

function! s:IsOpen()
  return exists('s:Current')
endfunction

function! s:ChangeDirectory()
  if has_key(s:Current, 'path') == 1
    exec 'cd ' . s:Current['path']
  end
  return s:Current['path']
endfunction

function! s:RefreshCurrent(rBrowser)
  if s:IsOpen()
    call s:ChangeDirectory()

    if has_key(s:Current, 'vim') == 1
      exec 'so ' . s:Current['vim']
    end

    if match(g:ProjFileBrowser, 'off') != 0
      if has_key(s:Current, 'browser') == 1
        if match(s:Current['browser'], 'off') != 0
          exec s:Current['browser']
        else
          echo 'Browser disabled'
        end
      elseif a:rBrowser
        exec g:ProjFileBrowser
      end
    else
      echo 'Browser disabled'
    end
  end

  if s:auInit == 0
    let s:auInit = 1
    au TabEnter * silent call s:OnTabEnter()
    au TabLeave * silent call s:OnTabLeave()
    if exists('*TransmitFtpSendFile')
      au BufWritePost * silent call s:TransmitDocksend()
    end
  end
endfunction

function! s:TransmitDocksend()
  if has_key(s:Current, 'docksend') && match(expand('%:p:h'), s:Current['path']) == 0
    call TransmitFtpSendFile()
  end
endfunction

function! s:AddProject(name)
  let item = ['', '[' . a:name . ']', 'path = ' . getcwd()]
  if(s:ReadFile('s:CurrentFile'))
    let lines = s:CurrentFile + item
  else
    let lines = item
  end
  call writefile(lines, s:GetFile())
  call s:LoadProjects()
endfunction

function! s:OpenVimFile()
  if s:IsOpen()
    if has_key(s:Current, 'vim') == 1
      exec join([g:ProjSplitMethod . s:Current['vim']], ' ')
    end
  end
endfunction

function! s:OpenFile()
  if s:FileReadable()
    exec join([g:ProjSplitMethod, s:GetFile()], ' ')
  end
endfunction

function! s:DumpInfo()
  if s:IsOpen()
    let output = ''
    for key in keys(s:Current)
      let output = output . key . '=' . s:Current[key] . '; '
    endfor
    echo output
  end
endfunction

function! s:OpenNotes()
  if s:IsOpen()
    if has_key(s:Current, 'notes') == 1
      let noteFile = s:Current['notes']
    else
      let noteFile = g:ProjNoteFile
    end

    if expand('%') == noteFile
      quit
    else
      exec join([g:ProjSplitMethod, noteFile], ' ')
    end
  end
endfunction

function! s:Set(var, val)
  if !exists(a:var)
    exec 'let ' . a:var . ' = ' . string(a:val)
  end
endfunction

call s:Set('g:ProjFile', '~/.vimproj')
call s:Set('g:ProjFileBrowser', 'NERDTree')
call s:Set('g:ProjNoteFile', 'notes.txt')
call s:Set('g:ProjSplitMethod', 'vsp')

call s:Set('g:ProjDisableMappings', 0)
call s:Set('g:ProjMapLeader', '<Leader>p')

call s:Set('g:ProjAddMap',     g:ProjMapLeader . 'a')
call s:Set('g:ProjFileMap',    g:ProjMapLeader . 'f')
call s:Set('g:ProjInfoMap',    g:ProjMapLeader . 'i')
call s:Set('g:ProjMenuMap',    g:ProjMapLeader . 'm')
call s:Set('g:ProjNotesMap',   g:ProjMapLeader . 'n')
call s:Set('g:ProjOpenMap',    g:ProjMapLeader . 'o')
call s:Set('g:ProjOpenTabMap', g:ProjMapLeader . 't')
call s:Set('g:ProjReloadMap',  g:ProjMapLeader . 'r')
call s:Set('g:ProjVimMap',     g:ProjMapLeader . 'v')

call s:LoadProjectsRaw()

function! s:Map(type, key, cmd)
  exec join([a:type, a:key, a:cmd], ' ')
endfunction

function! s:NormalMap(key, cmd)
  exec s:Map('nnoremap', a:key, a:cmd)
endfunction

function! s:PromptMenu()
  let choice = input("Proj Menu\n"
                   \." (a)dd\n"
                   \." (f)ile\n"
                   \." (i)nfo\n"
                   \." (n)otes\n"
                   \." (o)pen\n"
                   \." (t)ab open\n"
                   \." (r)eload\n"
                   \." (v)im\n"
                   \."? ")
  if choice == 'a'
    call s:PromptAdd()
  elseif choice == 'f'
    call s:OpenFile()
  elseif choice == 'i'
    call s:DumpInfo()
  elseif choice == 'n'
    call s:OpenNotes()
  elseif choice == 'o'
    call s:PromptOpen()
  elseif choice == 'r'
    call s:LoadProjects()
  elseif choice == 't'
    call s:PromptOpenTab()
  elseif choice == 'v'
    call s:OpenVimFile()
  end
endfunction

function! s:PromptOpen()
  let name = input('Open: ', '', 'customlist,g:ProjComplete')
  if len(name)
    call s:OpenProject(name, 1)
  end
endfunction

function! s:PromptOpenTab()
  let name = input('Open Tab: ', '', 'customlist,g:ProjComplete')
  if len(name)
    call s:OpenProjectTab(name)
  end
endfunction

function! s:PromptAdd()
  let name = input('New Project Name: ')
  if len(name)
    call s:AddProject(name)
  end
endfunction

if g:ProjDisableMappings != 1
  call s:NormalMap(g:ProjAddMap,     ':ProjAdd<CR>')
  call s:NormalMap(g:ProjFileMap,    ':ProjFile<CR>')
  call s:NormalMap(g:ProjInfoMap,    ':ProjInfo<CR>')
  call s:NormalMap(g:ProjMenuMap,    ':ProjMenu<CR>')
  call s:NormalMap(g:ProjNotesMap,   ':ProjNotes<CR>')
  call s:NormalMap(g:ProjOpenMap,    ':ProjOpen<CR>')
  call s:NormalMap(g:ProjOpenTabMap, ':ProjOpenTab<CR>')
  call s:NormalMap(g:ProjReloadMap,  ':ProjReload<CR>')
  call s:NormalMap(g:ProjVimMap,     ':ProjVim<CR>')
end

function! g:ProjComplete(A, L, P)
  if(exists('g:Projects'))
    return filter(keys(g:Projects), 'v:val =~ "^' . a:A . '"')
  end
endfunction


command! -complete=customlist,g:ProjComplete -nargs=1 Proj :call s:OpenProject('<args>', 1)
command! ProjAdd     :call s:PromptAdd()
command! ProjFile    :call s:OpenFile()
command! ProjInfo    :call s:DumpInfo()
command! ProjMenu    :call s:PromptMenu()
command! ProjNotes   :call s:OpenNotes()
command! ProjOpen    :call s:PromptOpen()
command! ProjOpenTab :call s:PromptOpenTab()
command! ProjRefresh :call s:RefreshCurrent()
command! ProjReload  :call s:LoadProjects()
command! ProjVim     :call s:OpenVimFile()
