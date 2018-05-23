# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# display the openblas configuration
openblas.info:
	${call log.sec,"openblas",}
	${call log.var,"version",$(openblas.version)}
	${call log.var,"blas",$(openblas.blas)}
	${call log.var,"configuration file",$(openblas.config)}
	${call log.var,"home",$(openblas.dir)}
	${call log.var,"compiler flags",$(openblas.flags)}
	${call log.var,"defines",$(openblas.defines)}
	${call log.var,"incpath",$(openblas.incpath)}
	${call log.var,"linker flags",$(openblas.ldflags)}
	${call log.var,"libpath",$(openblas.libpath)}
	${call log.var,"libraries",$(openblas.libraries)}
	${call log.var,"c++ compile line",${call package.compile.options,c++,openblas}}
	${call log.var,"c++ link line",${call package.link.options,c++,openblas}}

# end of file
