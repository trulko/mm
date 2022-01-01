# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2022 all rights reserved
#

# default compilers; specify as many as necessary in the form {family} or {family/language}
platform.compilers = gcc python cython

# clean up the debug symbols compilers leave behind
#     platform.clean {stem}
platform.clean = $(1).dSYM


# end of file
