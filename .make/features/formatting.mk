# Copyright © 2019 djrlj694.dev. All rights reserved.
#==============================================================================#
# PROGRAM: formatting.mk
# AUTHORS: Robert L. Jones
# COMPANY: djrlj694.dev
# VERSION: 1.0.0
# CREATED: 16MAR2019
# REVISED: 25MAY2019
#==============================================================================#
# For info on terminology or style conventions, see ".make/README.md".
#==============================================================================#

#==============================================================================#
# INTERNAL CONSTANTS
#==============================================================================#

#------------------------------------------------------------------------------#
# Special characters
#------------------------------------------------------------------------------#

# C-style octal code representing an ASCI escape character.
ESC := \033

EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

#------------------------------------------------------------------------------#
# ANSI escape sequences
#------------------------------------------------------------------------------#

# Setting the text intensity/emphasis of STDOUT.
RESET := $(ESC)[0m
BOLD := $(ESC)[1m
DIM := $(ESC)[2m

# Setting the text color of STDOUT.
FG_CYAN := $(ESC)[0;36m
FG_GREEN := $(ESC)[0;32m
FG_RED := $(ESC)[0;31m
FG_YELLOW := $(ESC)[1;33m
