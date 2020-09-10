# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Cookiecutter.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 10MAR2019
# REVISED: 10SEP2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# -- Command Output -- #

COOKIECUTTER ?= $(shell which cookiecutter)


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Debugging & Error Capture -- #

VARIABLES_TO_SHOW += COOKIECUTTER

# -- Help Strings -- #

MAKE_ARGS += [COOKIECUTTER=]


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisite for "init" Target -- #

.PHONY: init-cookiecutter init-cookiecutter-files

## init-cookiecutter: Completes all initial Cookiecutter setup activites.
init-cookiecutter: init-cookiecutter-files

## init-cookiecutter-files: Adds headers to all Swift files.
init-cookiecutter-files: | $(LOG)
	@echo "Initializing Cookiecutter files."
	@mv .boilerplate/Cookiecutter/* . >$(LOG) 2>&1; \
	$(status_result)


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
