# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# librarian
ar = ar
ar.create = $(ar) $(ar.flags.create)
ar.extract = $(ar) $(ar.flags.extract)
ar.remove = $(ar) $(ar.flags.remove)
ar.update = $(ar) $(ar.flags.update)
ar.flags.create = rc
ar.flags.extract = x
ar.flags.remove = d
ar.flags.update = ru

# ranlib
ranlib = ranlib
ranlib.flags =

# loader
ld = ld
ld.out = $(ld) $(ld.flags.out)
ld.shared = $(ld) $(ld.flags.shared)
ld.flags.out =  -o
ld.flags.shared =  -shared

# copy
cp = cp
cp.f = $(cp) $(cp.flags.force)
cp.r = $(cp) $(cp.flags.recurse)
cp.fr = $(cp) $(cp.flags.force-recurse)
cp.flags.force = -f
cp.flags.recurse = -r
cp.flags.force-recurse = -fr

# move
mv = mv
mv.f = $(mv) $(mv.flags.force)
mv.flags.force = -f

# file attributes
chmod = chmod
chmod.recurse = $(chmod) $(chmod.flags.recurse)
chmod.write = $(chmod) $(chmod.flags.write)
chmod.write-recurse = $(chmod.recurse) $(chmod.flags.write)
chmod.flags.recurse = -R
chmod.flags.write = +w

chown = chown
chown.recurse = $(chown) $(chown.flags.recurse)
chown.flags.recurse = -R

chgrp = chgrp
chgrp.recurse = $(chgrp) $(chgrp.flags.recurse)
chgrp.flags.recurse = -R

# directories
cd = cd
mkdir = mkdir
mkdirp = $(mkdir) $(mkdir.flags.make-parents)
mkdir.flags.make-parents = -p

# remove
rm = rm
rm.force = $(rm) $(rm.flags.force)
rm.recurse = $(rm) $(rm.flags.recurse)
rm.force-recurse = $(rm) $(rm.flags.force-recurse)
rm.flags.force = -f
rm.flags.recurse = -r
rm.flags.force-recurse = -rf

rmdir = rmdir

# rsync
rsync = rsync
rsync.recurse = $(rsync) $(rsync.flags.recurse)
rsync.flags.recurse = -ruavz --progress --stats

# ssh
ssh = ssh
scp = scp
scp.recurse = $(scp) $(scp.flags.recurse)
scp.flags.recurse = -r

# tags
tags = true
tags.flags =
tags.home =
tags.file = $(tags.home)/TAGS

# tar
tar = tar
tar.flags.create = -cvj -f

# TeX and associated tools
tex.tex = tex
tex.latex = latex
tex.pdflatex = pdflatex
tex.bibtex = bibtex
tex.dvips = dvips
tex.dvipdf = dvipdf

# yacc
yacc = yacc
yacc.c = y.tab.c
yacc.h = y.tab.h

# end of file
