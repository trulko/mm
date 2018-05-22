# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# show me
# ${info -- libraries.init}

# the list of libraries encountered
libraries ?=

# the libraries constructor
#  usage: libraries.init {project instance} {library name}
define libraries.init =
    # local assignments
    ${eval project := $(1)}
    ${eval library := $(2)}

    # add it to the pile
    ${eval libraries += $(library)}
    # save the project
    ${eval $(library).project := $(project)}
    # the stem for generating library specific names; it can get used to build the archive
    # name and the include directory with the public headers
    ${eval $(library).stem ?=}
    # form the name
    ${eval $(library).name := lib$($(library).stem)}
    # the name of the archive
    ${eval $(library).archive = $($(library).name)$(builder.ext.lib)}

    # dependencies
    # initialize the list of requested project dependencies
    ${eval $(library).extern.requested ?=}
    # the list of external dependencies that we have support for
    ${eval $(library).extern.supported ?=}
    # the list of dependecies in the order they affect the compiler command lines
    ${eval $(library).extern.available ?=}

    # build locations
    # the destination for the archive
    ${eval $(library).libdir = $(builder.libdir)}
    # the destination for the public headers
    ${eval $(library).incdir = $(builder.incdir)/$($(library).stem)}
    # the location of the build transients
    ${eval $(library).tmpdir = $(builder.tmpdir)/$(project)/$($(library).name)}

    # artifacts
    # the root of the library source tree relative to the project home
    ${eval $(library).root ?= lib/lib$($(library).stem)}
    # the absolute path to the library source tree
    ${eval $(library).prefix ?= $($($(library).project).home)/lib/lib$($(library).stem)}

    # the directory structure
    ${eval $(library).directories ?= ${call library.directories,$(library)}}
    # the list of sources
    ${eval $(library).sources ?= ${call library.sources,$(library)}}
    # the public headers
    ${eval $(library).headers ?=${call library.headers,$(library)}}

    # derived artifacts
    # the compile products
    $(library).staging.objects = ${call library.objects,$(library)}
    # the archive
    $(library).staging.archive = $($(library).libdir)/$($(library).archive)
    # the include directories in the staging area
    $(library).staging.incdirs = $($(library).directories:%=$($(library).incdir)/%)
    # the public headers in the staging area
    $(library).staging.headers = $($(library).headers:%=$($(library).incdir)/%)

    # implement the external protocol
    # compile time
    $(library).flags ?=
    $(library).defines ?=
    $(library).incpath ?= $(builder.incdir) # note: NOT ($(library).incdir)
    # link time
    $(library).ldflags ?=
    $(library).libpath ?= $($(library).libdir) # that's where we put it
    $(library).libraries ?= $($(library).stem) # that's what we call it

    # documentation
    $(library).meta.categories := general extern locations artifacts derived external

    # category documentation
    $(library).metadoc.general := "general information"
    $(library).metadoc.extern := "dependencies to external packages"
    $(library).metadoc.locations := "the locations of the build products"
    $(library).metadoc.artifacts := "information about the sources"
    $(library).metadoc.derived := "the compiled products"
    $(library).metadoc.external := "how to compile and link against this library"

    # build a list of all project attributes by category
    $(library).meta.general := name stem
    $(library).meta.extern := extern.requested extern.supported extern.available
    $(library).meta.locations := incdir libdir tmpdir
    $(library).meta.artifacts := root prefix directories sources headers
    $(library).meta.derived := staging.archive staging.objects staging.incdirs staging.headers
    $(library).meta.external := flags defines incpath ldflags libpath libraries

    # document each one
    # general
    $(library).metadoc.name := "the name of the library"
    $(library).metadoc.stem := "the stem for generating product names"
    # dependencies
    $(library).metadoc.extern.requested := "requested dependencies"
    $(library).metadoc.extern.supported := "the dependencies for which there is mm support"
    $(library).metadoc.extern.available := "dependencies that were actually found and used"
    # locations
    $(library).metadoc.libdir := "the destination of the archive"
    $(library).metadoc.incdir := "the destination of the public headers"
    $(library).metadoc.tmpdir = "the staging area for object modules"
    # artifacts
    $(library).metadoc.root := "the path to the library sources relative to the project directory"
    $(library).metadoc.prefix := "the absolute path to the root of the library source tree"
    $(library).metadoc.directories := "the source directory structure"
    $(library).metadoc.sources := "the archive sources"
    $(library).metadoc.headers := "the public headers"
    # derived
    $(library).metadoc.staging.archive = "the archive"
    $(library).metadoc.staging.objects = "the object modules"
    $(library).metadoc.staging.incdirs = "the header directory structure"
    $(library).metadoc.staging.headers = "the public headers files"
    # external
    $(library).metadoc.flags := "compiler flags"
    $(library).metadoc.defines := "preprocessor macros"
    $(library).metadoc.incpath := "tell the compiler where the headers are"
    $(library).metadoc.ldflags := "link time flags"
    $(library).metadoc.libpath := "the path to the archives"
    $(library).metadoc.libraries := "the list of archives to place on the link line"

# all done
endef

# methods

# build the set of library directories
#   usage: library.directories {library}
define library.directories
    ${strip
        ${subst
            $($(library).prefix)/,,
            ${shell find $($(library).prefix)/* -type d}
        }
    }
endef

# build the set of archive sources
#   usage: library.sources {library}
define library.sources
    ${strip
        ${foreach
            directory,
            $($(library).directories),
            ${subst
                $($(library).prefix)/,,
                ${wildcard
                    ${addprefix
                        $($(library).prefix)/$(directory)/*.,
                        ${foreach language, $(languages), $(languages.$(language).sources)}
                    }
                }
            }
        }
    }
endef

# build the set of archive headers
#   usage: library.headers {library}
define library.headers
    ${strip
        ${foreach directory,$($(library).directories),
            ${subst
                $($(library).prefix)/,,
                ${wildcard
                    ${addprefix
                        $($(library).prefix)/$(directory)/*.,
                        ${sort
                            ${foreach language, $(languages), $(languages.$(language).headers)}
                        }
                    }
                }
            }
        }
    }
endef


# build the set of archive objects
#   usage: library.objects {library}
define library.objects
    ${addsuffix
        $(builder.ext.obj),
        ${subst
            /,~,
            ${basename $($(library).sources)}
        }
    }
endef


# mangle the path to a source file to create the filename of an object; single filename version
# of the above
#  usage: library.object {source}
define library.object
    ${subst /,~,${basename $(1)}}
endef


# show me
# ${info -- done with libraries.init}

# end of file
