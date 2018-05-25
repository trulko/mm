# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# show me
# ${info -- libraries.info}


# library help
# make the recipe
libraries.info: mm.banner
	$(log) "known libraries: "$(palette.purple)$(libraries)$(palette.normal)
	$(log)
	$(log) "to build one of them, use its name as a target"
	$(log) "    mm ${firstword $(libraries)}"
	$(log)
	$(log) "to get more information about a specific library, use"
	$(log) "    mm ${firstword $(libraries)}.info"
	$(log)


# bootstrap
# make the library specific targets
#  usage: library.workflows {libraries}
define library.workflows =
    # build recipes
    ${call library.workflows.build,$(library)}
    # info recipes: show values
    ${call library.workflows.info,$(library)}
    # help recipes: show documentation
    ${call library.workflows.help,$(library)}
# all done
endef


# build targets
# target factory for building a library
define library.workflows.build =
# the main recipe
$(library): $(library).directories $(library).assets
	${call log.asset,"library",$(library)}

$(library).directories: $($(library).libdir) $($(library).staging.incdirs) $($(library).tmpdir)

$($(library).libdir) $($(library).staging.incdirs) $($(library).tmpdir):
	$(mkdirp) $$@
	${call log.action,"mkdir",$$@}

$(library).assets: $(library).headers $(library).archive

$(library).headers: $($(library).staging.headers)

# make the rules that publish the exported headers
${foreach header, $($(library).headers), \
    ${eval ${call library.workflows.header $(library),$(header)}}
}

$(library).archive: $($(library).staging.archive)

$($(library).staging.archive): $($(library).staging.objects)
	$(ar.create) $$@ $($(library).staging.objects)
	${call log.action,"ar",$($(library).archive)}

# make the rules that compile the archive sources
${foreach source,$($(library).sources), \
    ${eval ${call library.workflows.object,$(library),$(source)}}
}

# include the dependency files
-include $($(library).staging.objects:$(builder.ext.obj)=$(builder.ext.dep)) \

# all done
endef


# helpers
# library headers
#  usage: library.workflows.header {library} {header}
define library.workflows.header =
# publish public headers
${call library.staging.header,$(header)}: $(header) | ${call library.staging.incdir,$(header)}
	$(cp) $$< $$@
	${call log.action,"publish",${subst $($($(library).project).home)/,,$(header)}}
# all done
endef


# library objects
#  usage: library.workflows.object {library} {source}
define library.workflows.object =

    # compute the absolute path of the source
    ${eval source.path := $(2)}
    # and the path to the object module
    ${eval source.object := ${call library.staging.object,$(1),$(2)}}
    # figure out the source language
    ${eval source.language := $(ext${suffix $(2)})}

# compile source files
$(source.object): $(source.path)
	${call log.action,"$(source.language)",${subst $($($(library).project).home)/,,$(source)}}
	${call languages.$(source.language).compile,$(library),$(source.object),$(source.path)}
	${if $($(compiler.$(source.language)).compile.generate-dependencies), \
            $(cp) $$(@:$(builder.ext.obj)=$(builder.ext.dep)) $$@.$$$$ ; \
            $(sed) \
                -e 's/\#.*//' \
                -e 's/^[^:]*: *//' \
                -e 's/ *\\$$$$//' \
                -e '/^$$$$/d' \
                -e 's/$$$$/ :/' \
                $$(@:$(builder.ext.obj)=$(builder.ext.dep)) \
                    < $$(@:$(builder.ext.obj)=$(builder.ext.dep)) >> $$@.$$$$ ; \
            $(mv) $$@.$$$$ $$(@:$(builder.ext.obj)=$(builder.ext.dep)), \
        }

# all done
endef


# make a recipe to log the metadata of a specific library
# usage: library.workflows.info {library}
define library.workflows.info =
# make the recipe
$(1).info:
	${call log.sec,$(1),"a library in project '$($(library).project)'"}
	$(log)
	${call log.var,headers,$($(1).incdir)}
	${call log.var,archive,$($(1).staging.archive)}
	${call log.var,source root,$($(1).prefix)}
	${call log.var,requested packages,$($(1).extern.requested)}
	${call log.var,supported packages,$($(1).extern.supported)}
	${call log.var,available packages,$($(1).extern.available)}
	$(log)
	$(log) "for an explanation of their purpose, try"
	$(log)
	$(log) "    mm $(1).help"
	$(log)
	$(log) "related targets:"
	$(log)
	${call log.help,$(1).info.directories,"the layout of the source directories"}
	${call log.help,$(1).info.sources,"the source files"}
	${call log.help,$(1).info.headers,"the header files"}
	${call log.help,$(1).info.incdirs,"the include directories in the staging area"}
	${call log.help,$(1).info.api,"the exported public headers"}
	${call log.help,$(1).info.objects,"the object files in the staging area"}


# make a recipe that prints the directory layout of the sources of a library
$(1).info.directories:
	${call log.sec,$(1),"a library in project '$($(1).project)'"}
	${call log.sec,"  source directories",}
	${foreach directory,$($(1).directories),$(log) $(log.indent)$(directory);}


# make a recipe that prints the set of sources that comprise a library
$(1).info.sources:
	${call log.sec,$(1),"a library in project '$($(1).project)'"}
	${call log.sec,"  sources",}
	${foreach source,$($(1).sources),$(log) $(log.indent)$(source);}


# make a recipe that prints the set of public headers of a library
$(1).info.headers:
	${call log.sec,$(1),"a library in project '$($(1).project)'"}
	${call log.sec,"  headers",}
	${foreach header,$($(1).headers),$(log) $(log.indent)$(header);}
# all done

# make a recipe that prints the set of objects of a library
$(1).info.objects:
	${call log.sec,$(1),"a library in project '$($(1).project)'"}
	${call log.var,"tmpdir",$($(1).tmpdir)}
	${call log.sec,"  objects",}
	${foreach object,$($(1).staging.objects),$(log) $(log.indent)$(object);}


# make a recipe that prints the set of includes of a library
$(1).info.incdirs:
	${call log.sec,$(1),"a library in project '$($(1).project)'"}
	${call log.var,"incdir",$($(1).incdir)}
	${call log.sec,"  include directory structure",}
	${foreach directory,$($(1).staging.incdirs),$(log) $(log.indent)$(directory);}

# make a recipe that prints the set of exported public headers
$(1).info.api:
	${call log.sec,$(1),"a library in project '$($(1).project)'"}
	${call log.var,"incdir",$($(1).incdir)}
	${call log.sec,"  exported public headers",}
	${foreach header,$($(1).staging.headers),$(log) $(log.indent)$(header);}

# all done
endef


# make a recipe to show the metadata documentation of a specific library
# usage: library.workflows.help {library}
define library.workflows.help =
# make the recipe
$(1).help:
	$(log)
	${call log.sec,$(1),library attributes}
	$(log)
	${foreach category,$($(library).meta.categories),\
            ${call log.sec,"  "$(category),$($(1).metadoc.$(category))}; \
            ${foreach var,$($(1).meta.$(category)), \
                ${call log.help,$(1).$(var),$($(1).metadoc.$(var))}; \
             } \
        } \
	$(log)
	$(log) "for a listing of their values, try"
	$(log)
	$(log) "    mm $(1).info"
	$(log)
# all done
endef


# show me
# ${info -- done with libraries.info}

# end of file
