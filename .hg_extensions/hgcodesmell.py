# -*- coding: utf-8 -*-
#
# codesmell mercurial extension
#
# Copyright (c) 2009-2010 by Georg Brandl.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
# Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
"""warn about smelly changes in added code before allowing a commit

Usage: activate the extension in your hgrc file::

    [extensions]
    hgcodesmell = path/to/hgcodesmell.py

Then, when "smelly" changes would be committed, they will be printed out and you
will be prompted whether to actually do the commit.
"""

import os
import re
import fnmatch

from mercurial import commands, cmdutil, extensions, patch

try:
    # use the color extension to render diffs, if it is recent enough
    from hgext import color
    if hasattr(color, 'colorwrap'):
        def write_colored(ui, diff):
            color.colorwrap(ui.write, ''.join(diff))
    elif hasattr(color, 'render_effects'):
        # hg 1.6: different API
        def write_colored(ui, diff):
            for output, label in patch.difflabel(lambda: diff):
                ui.write(output, label=label)
    else:
        raise ImportError
except ImportError:
    def write_colored(ui, diff):
        ui.write(''.join(diff))

# smelly patterns are tuples (regex, reason)
print_stmt = (re.compile(r'^\+\s*print\b'), 'print statement')
debugger_stmt = (re.compile(r'^\+\s*debugger;'), 'javascript debugger')
zero_div = (re.compile(r'^\+\s*1/0'), 'zero division error')
set_trace = (re.compile(r'\bpdb\.set_trace\(\)'), 'set_trace')
vim_cmd = (re.compile(r':(w|wq|q|x)$', re.M), 'vim exit command')
windows_nl = (re.compile(r'\r'), 'Windows newline')
merge_marker = (re.compile(r'^(>>>>>>>|<<<<<<<)'), 'merge marker')

# the master dict maps glob patterns to a list of smelly patterns
SMELLY_STUFF = {
    '*.js': [debugger_stmt],
    '*.py': [print_stmt, zero_div, set_trace],
    '*': [vim_cmd, merge_marker],
}

if os.name != 'nt':
    # only pick on Windows newlines if not on Windows
    SMELLY_STUFF['*'].append(windows_nl)


def new_commit(orig_commit, ui, repo, *pats, **opts):
    smelly_count = 0
    match = cmdutil.match(repo, pats, opts)
    revs = cmdutil.revpair(repo, None)
    changes = repo.status(*revs, match=match)
    if changes[1]:
        # check if any added files would be ignored
        for fn in changes[1]:
            if repo.dirstate._ignore(fn):
                ui.warn('File %r added, but it would be ignored.\n' % fn)
                smelly_count += 1
    diff = patch.diff(repo, *revs, match=match)
    smellies = []
    for chunk in diff:
        chunklines = chunk.splitlines(True)
        indexline = 0
        hunkstart = 0
        for i, line in enumerate(chunklines):
            if line.startswith('diff'):
                indexline = i
                # new file: collect all smelly patterns for it
                filename = line.split()[-1]
                smellies = []
                for pat, smelly in SMELLY_STUFF.iteritems():
                    if not fnmatch.fnmatch(filename, pat):
                        continue
                    smellies.extend(smelly)
            elif line.startswith('@@'):
                hunkstart = i
            elif line.startswith('+'):
                for rex, reason in smellies:
                    if rex.search(line):
                        ui.warn('Smelly change (%s):\n' % reason)
                        diff = chunklines[indexline:indexline+3] + \
                               chunklines[hunkstart:i+4]
                        write_colored(ui, diff)
                        smelly_count += 1
                        break
                else:
                    continue
                break
    if smelly_count:
        if not ui.prompt('Found %d smelly change%s. Continue (y/N)?' %
                         (smelly_count, smelly_count != 1 and 's' or ''),
                         default='n').lower().startswith('y'):
            return smelly_count
    return orig_commit(ui, repo, *pats, **opts)

def uisetup(ui):
    extensions.wrapcommand(commands.table, 'commit', new_commit)
