# -*- Makefile -*-
#
# michael a.g. aïvázis <michael.aivazis@para-sim.com>
# (c) 1998-2023 all rights reserved

# show me
# ${info -- geotiff.init}

# add me to the pile
extern += ${if ${findstring geotiff,$(extern)},,geotiff}

# # find my configuration file
geotiff.config := ${dir ${call extern.config,geotiff}}

# compiler flags
geotiff.flags ?=
# enable {geotiff} aware code
geotiff.defines := WITH_GEOTIFF
# the canonical form of the include directory
geotiff.incpath ?= $(geotiff.dir)/include

# linker flags
geotiff.ldflags ?=
# the canonical form of the lib directory
geotiff.libpath ?= $(geotiff.dir)/lib
# the names of the libraries
geotiff.libraries := geotiff tiff

# my dependencies
geotiff.dependencies = tiff

# show me
# ${info -- done with geotiff.init}

# end of file
