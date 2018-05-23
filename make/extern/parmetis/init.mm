# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# add me to the pile
packages += parmetis

# compiler flags
parmetis.flags ?=
# enable {parmetis} aware code
parmetis.defines := WITH_PARMETIS
# the canonical form of the include directory
parmetis.incpath ?= $(parmetis.dir)/include

# linker flags
parmetis.ldflags ?=
# the canonical form of the lib directory
parmetis.libpath ?= $(parmetis.dir)/lib
# the names of the libraries
parmetis.libraries := parmetis

# my dependencies
parmetis.dependencies = metis

# end of file
