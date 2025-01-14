# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2023 all rights reserved
#

# show me
# ${info -- mm.init}

# tokens
comma := ,
empty :=
space := $(empty) $(empty)

# some of these may be set already by the {mm.py} driver
# mm info
mm ?=
mm.version ?=
mm.home ?=
mm.merlin ?=
mm.compilers ?=

# contributions to the build
mm.flags ?=
mm.defines ?=
mm.incpath ?=
mm.ldflags ?=
mm.libpath ?=
mm.libraries ?=

# influence the build
# add an include path to the build to facilitate compiling products against specific targets
#   usage: mm.compile.options {language}
mm.compile.options = \
    ${addprefix $($(compiler.$(1)).prefix.incpath),$(mm.incpath)}

# add a library search path to the build to facilitate linking products against specific targets
#   usage: mm.link.options {language}
mm.link.options = \
    ${addprefix $($(compiler.$(1)).prefix.libpath),$(mm.libpath)}

# contribution to the config path
mm.config := $(mm.home)

# show me
# ${info -- done with mm.init}

# end of file
