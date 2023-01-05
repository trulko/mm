# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2023 all rights reserved
#

# show me
# ${info -- p2.info}

# display the p2 configuration
extern.p2.info:
	@${call log.sec,"p2",}
	@${call log.var,"version",$(p2.version)}
	@${call log.var,"configuration file",$(p2.config)}
	@${call log.var,"home",$(p2.dir)}
	@${call log.var,"compiler flags",$(p2.flags)}
	@${call log.var,"defines",$(p2.defines)}
	@${call log.var,"incpath",$(p2.incpath)}
	@${call log.var,"linker flags",$(p2.ldflags)}
	@${call log.var,"libpath",$(p2.libpath)}
	@${call log.var,"libraries",$(p2.libraries)}
	@${call log.var,"dependencies",$(p2.dependencies)}
	@${call log.var,"c++ compile line",${call extern.compile.options,c++,p2}}
	@${call log.var,"c++ link line",${call extern.link.options,c++,p2}}

# show me
# ${info -- done with p2.info}

# end of file
