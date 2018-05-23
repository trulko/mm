# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# add me to the pile
packages += petsc

# compiler flags
petsc.flags ?=
# enable {petsc} aware code
petsc.defines := WITH_PETSC PETSC_USE_EXTERN_CXX
# the canonical form of the include directory
petsc.incpath ?= $(petsc.dir)/include

# linker flags
petsc.ldflags ?=
# the canonical form of the lib directory
petsc.libpath ?= $(petsc.dir)/lib
# the names of the libraries
petsc.libraries := petsc

# my dependencies
petsc.dependencies =

# end of file
