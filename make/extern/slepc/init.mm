# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# add me to the pile
packages += slepc

# compiler flags
slepc.flags ?=
# enable {slepc} aware code
slepc.defines := WITH_SLEPC SLEPC_USE_EXTERN_CXX
# the canonical form of the include directory
slepc.incpath ?= $(slepc.dir)/include

# linker flags
slepc.ldflags ?=
# the canonical form of the lib directory
slepc.libpath ?= $(slepc.dir)/lib
# the names of the libraries
slepc.libraries := slepc

# my dependencies
slepc.dependencies = petsc

# end of file
