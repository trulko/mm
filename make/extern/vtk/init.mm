# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2023 all rights reserved
#

# show me
# ${info -- vtk.init}

# add me to the pile
extern += ${if ${findstring vtk,$(extern)},,vtk}

# # find my configuration file
vtk.config := ${dir ${call extern.config,vtk}}

# users set this variable to communicate which libraries they want
vtk.required ?=

# compiler flags
vtk.flags ?=
# enable {vtk} aware code
vtk.defines := WITH_VTK
# the canonical form of the include directory
vtk.incpath ?= $(vtk.dir)/include/vtk-$(vtk.version)

# linker flags
vtk.ldflags ?=
# the canonical form of the lib directory
vtk.libpath ?= $(vtk.dir)/lib
# the way library names are formed is version dependent; we support 6.x and higher
vtk.libraries := \
    ${foreach \
        requirement, \
        $(vtk.required), \
        vtk$(requirement)-$(vtk.version) \
    }

# show me
# ${info -- done with vtk.init}

# end of file
