# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Cookiecutter.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 10MAR2019
# REVISED: 19AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #

# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

#------------------------------------------------------------------------------#
# Command output
#------------------------------------------------------------------------------#

COOKIECUTTER ?= $(shell which cookiecutter)

# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

#------------------------------------------------------------------------------#
# Debugging & error capture
#------------------------------------------------------------------------------#

VARIABLES_TO_SHOW += COOKIECUTTER

#------------------------------------------------------------------------------#
# Help strings
#------------------------------------------------------------------------------#

MAKE_ARGS += [COOKIECUTTER=]

# ============================================================================ #
# USER-DEFINED FUNCTIONS
# ============================================================================ #

# $(call sed-cmd,cc_var,replacement)
# Generates a sed command for substituting a Cookiecutter template variable with
# a replacement value.
# FIXME: Not escaping the curly braces results in the following error during
# FIXME: the execution of Cookiecutter:
# FIXME: jinja2.exceptions.TemplateSyntaxError: unexpected char '$' at 1953
# FIXME:   File "./.make/platforms/Cookiecutter.mk", line 48
ifeq ($(COOKIECUTTER),)
cc-sed-cmd = s/\{\{ cookiecutter.$1 \}\}/$2/g
endif

# ============================================================================ #
# UTILITY DEPENDENCIES
# ============================================================================ #

ifeq ($(COOKIECUTTER),)
include $(MAKEFILE_DIR)/utilities/sed.mk
endif

# ============================================================================ #
# FEATURE DEPENDENCIES
# ============================================================================ #

ifeq ($(COOKIECUTTER),)
include $(MAKEFILE_DIR)/features/downloading.mk
include $(MAKEFILE_DIR)/features/setting_up.mk
endif
