# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: formatting.mk
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

# -- Special Characters -- #

# C-style octal code representing an ASCII escape character.
ESC := \033

# Whitespace.
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

# -- ANSI Escape Sequences -- #

# Text intensity/emphasis of STDOUT.
RESET := $(ESC)[0m
BOLD := $(ESC)[1m
DIM := $(ESC)[2m

# Text color of STDOUT.
FG_CYAN := $(ESC)[0;36m
FG_GREEN := $(ESC)[0;32m
FG_RED := $(ESC)[0;31m
FG_YELLOW := $(ESC)[1;33m


# ============================================================================ #
# INTERNAL VARIABLES
# ============================================================================ #

# -- Formatted Strings -- #

# Color-formatted names of filesystem paths.
dir_var = $(FG_CYAN)$(@D)$(RESET)
###file_var = $(FG_CYAN)$(basename $@)$(RESET) # RLJ: Commented out. 23FEEB2019, RRLJ
file_var = $(FG_CYAN)$(@F)$(RESET)
#subdir_var = $(FG_CYAN)$(subdir)$(RESET)
subdir_var = $(FG_CYAN)$(shell basename $(@D))$(RESET)

# Color-formatted name of the current makefile target being run.
target_var = $(FG_CYAN)$@$(RESET)
