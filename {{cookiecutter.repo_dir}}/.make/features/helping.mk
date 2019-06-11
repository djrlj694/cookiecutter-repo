# Copyright © 2019 djrlj694.dev. All rights reserved.
#==============================================================================#
# PROGRAM: helping.mk
# AUTHORS: Robert L. Jones
# COMPANY: djrlj694.dev
# VERSION: 1.0.0
# CREATED: 16MAR2019
# REVISED: 25MAY2019
#==============================================================================#
# For more info on terminology, style conventions, or source references, see
# the file ".make/README.md".
#==============================================================================#

#==============================================================================#
# INTERNAL CONSTANTS
#==============================================================================#

#------------------------------------------------------------------------------#
# Help strings
#------------------------------------------------------------------------------#

# Argument syntax for the "make" command.
MAKE_ARGS := [$(FG_CYAN)<target>$(RESET)]

#==============================================================================#
# INTERNAL VARIABLES
#==============================================================================#

#------------------------------------------------------------------------------#
# Help strings
#------------------------------------------------------------------------------#

# "Targets" section line item of the "make" command's online help.
target_help = $(FG_CYAN)%-17s$(RESET) %s

#==============================================================================#
# MACROS
#==============================================================================#

#------------------------------------------------------------------------------#
# Help strings
#------------------------------------------------------------------------------#

# "Targets" section header of the "make" command's online help.
define targets_help

Targets:

endef
export targets_help

# "Usage" section of the "make" command's online help.
define usage_help

Usage:
  make = make $(FG_CYAN)<target>$(RESET) $(MAKE_ARGS)

endef
export usage_help

#==============================================================================#
# PHONY TARGETS
#==============================================================================#

#------------------------------------------------------------------------------#
# Main phony targets
#------------------------------------------------------------------------------#

.PHONY: help

## help: Shows "make" command's online help.
help:
	@printf "$$usage_help"
	@printf "$$targets_help"
#	@cat $(MAKEFILE_LIST) | \
#	egrep '^[a-zA-Z_-]+:.*?##' | \
#	sed -e 's/:.* ##/: ##/' | sort -d | \
#	awk 'BEGIN {FS = ":.*?## "}; {printf "  $(target_help)\n", $$1, $$2}'
	@cat $(MAKEFILE_LIST) | \
	egrep '^## [a-zA-Z_-]+: ' | sed -e 's/## //' | sort -d | \
	awk 'BEGIN {FS = ": "}; {printf "  $(target_help)\n", $$1, $$2}'
	@echo ""
