# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2023 all rights reserved
#

# show me
# ${info -- libpq.init}

# add me to the pile
extern += ${if ${findstring libpq,$(extern)},,libpq}

# # find my configuration file
libpq.config := ${dir ${call extern.config,libpq}}

# compiler flags
libpq.flags ?=
# enable {libpq} aware code
libpq.defines := WITH_LIBPQ
# the canonical form of the include directory
libpq.incpath ?= $(libpq.dir)/include

# linker flags
libpq.ldflags ?=
# the canonical form of the lib directory
libpq.libpath ?= $(libpq.dir)/lib
# the names of the libraries
libpq.libraries := pq

# my dependencies
libpq.dependencies =

# show me
# ${info -- done with libpq.init}

# end of file
