# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: initializing.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 16MAR2019
# REVISED: 25AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Commands -- #

# A shortcut representing the "mkdir" command with the "-p" option.
MKDIR := mkdir -p


# ============================================================================ #
# INTERNAL VARIABLES
# ============================================================================ #

# -- Filesystem -- #

# Name of the subdirectory, represented by the current Makefile target being
# run. The shell command "basename" removes the parent directory, $(@D)), from
# the absolute path of the makefile target.
subdir = $(shell basename $(@D))

file = $(basename $@)


# ============================================================================ #
# DIRECTORY TARGETS
# ============================================================================ #

# Makes a directory tree.
%/.: | $(LOG)
	@printf "Making directory tree $(dir_var)..."
	@$(MKDIR) $(@D) >$(LOG) 2>&1; \
	$(status_result)
