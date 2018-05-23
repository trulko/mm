# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# display the libpq configuration
libpq.info:
	${call log.sec,"libpq",}
	${call log.var,"version",$(libpq.version)}
	${call log.var,"configuration file",$(libpq.config)}
	${call log.var,"home",$(libpq.dir)}
	${call log.var,"compiler flags",$(libpq.flags)}
	${call log.var,"defines",$(libpq.defines)}
	${call log.var,"incpath",$(libpq.incpath)}
	${call log.var,"linker flags",$(libpq.ldflags)}
	${call log.var,"libpath",$(libpq.libpath)}
	${call log.var,"libraries",$(libpq.libraries)}
	${call log.var,"dependencies",$(libpq.dependencies)}
	${call log.var,"c++ compile line",${call package.compile.options,c++,libpq}}
	${call log.var,"c++ link line",${call package.link.options,c++,libpq}}

# end of file
