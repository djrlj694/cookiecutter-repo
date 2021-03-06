# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Makefile
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 04FEB2019
# REVISED: 11SEP2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #

# .ONESHELL:
# .EXPORT_ALL_VARIABLES:


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# -- Accounts -- #

USER ?= $(shell whoami)

# -- Filesystem -- #

PREFIX ?= $(PWD)
REPO_NAME ?= $(shell basename $(PREFIX))


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

SHELL := bash


# ============================================================================ #
# INTERNAL VARIABLES
# ============================================================================ #

# -- Makefiles -- #

# Software platform target.
ifneq ($(PLATFORM),unspecified)
DOCS_PLATFORM := docs-$(shell echo $(PLATFORM) | tr A-Z a-z)
INIT_PLATFORM := init-$(shell echo $(PLATFORM) | tr A-Z a-z)
TEST_PLATFORM := test-$(shell echo $(PLATFORM) | tr A-Z a-z)
endif

# Absolute path of the directory containing files to be included as part of a
# makefile set.
MAKEFILE_DIR = $(dir $(realpath $(MAKEFILE)))/.make

# Name of the main makefile.
MAKEFILE = $(firstword $(MAKEFILE_LIST))


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Main Targets -- #

.PHONY: all build clean docs init test

all: help

ifeq ($(PLATFORM),Xcode)
## clean: Completes all cleaning activities.
clean: clean-git clean-xcode clean-github
endif

## docs: Makes API documentation.
docs: $(DOCS_PLATFORM)

## init: Completes all initial repo setup activities.
#init: init-github init-xcode init-swift init-git
#init: init-github $(INIT_PLATFORM) clean-common init-git init-git-flow
init: init-github $(INIT_PLATFORM) clean-common

## test: Completes all test activities.
#test: test-xcode test-swift
test: $(TEST_PLATFORM)


# ============================================================================ #
# FEATURE DEPENDENCIES
# ============================================================================ #

include $(MAKEFILE_DIR)/features/formatting.mk

include $(MAKEFILE_DIR)/features/debugging.mk
include $(MAKEFILE_DIR)/features/downloading.mk
include $(MAKEFILE_DIR)/features/helping.mk


# ============================================================================ #
# PLATFORM DEPENDENCIES
# ============================================================================ #

include $(MAKEFILE_DIR)/platforms/common.mk

include $(MAKEFILE_DIR)/platforms/Cookiecutter.mk
include $(MAKEFILE_DIR)/platforms/Git.mk
include $(MAKEFILE_DIR)/platforms/GitHub.mk
include $(MAKEFILE_DIR)/platforms/Swift.mk
#include $(MAKEFILE_DIR)/platforms/Xcode.mk
