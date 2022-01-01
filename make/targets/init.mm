# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2022 all rights reserved
#

# show me
# ${info -- target.init}

# user info
target ?= $(host.os)-$(host.arch)
# target tag
target.tag ?=
# variants are user specified confiugrations, such shared, debug, opt, cov, etc
target.variants ?=
# target-specific compiler choices
target.compilers ?=

# contribution to the config path
target.config =

# constructor
define target.init =
    ${foreach
        language,
        $(languages),
        ${foreach
            category,
            $(languages.$(language).categories),
            ${eval targets.$(1).$(language).$(category) ?=}
        }
    }
endef

# adjust the non-trivial settings for a given target
#  usage: target.adjust {target} {languages} {categories}
define target.adjust =
    ${foreach
        language,
        $(2),
        ${foreach
            category,
            $(3),
            ${eval
                targets.$(1).$(language).$(category) := \
                    ${if ${value compiler.$(language)},$($(compiler.$(language)).$(1)),}
            }
        }
    }
endef

# show me
# ${info -- done with target.init}

# end of file
