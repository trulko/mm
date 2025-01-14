# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2023 all rights reserved
#

# build the data model

# show me
# ${info -- builder.model}

# instantiate the builder
# we need project.bldroot and target.variants to have their final value by now....
${eval ${call builder.init,$(project.prefix),$(project.bldroot)}}

# make the builder targets
${eval ${call builder.workflows}}

# show me
# ${info -- done with builder.model}

# end of file
