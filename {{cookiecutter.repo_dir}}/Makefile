# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Makefile
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 04FEB2019
# REVISED: 18AUG2020
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

# -- Directories -- #

PREFIX ?= $(PWD)
PROJECT ?= $(shell basename $(PREFIX))
PACKAGE ?= $(PROJECT)


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Settings -- #

SHELL := bash

# -- Debugging & Error Capture -- #

# A list of makefile variables to show when testing/debugging.
VARIABLES_TO_SHOW := MAKEFILE MAKEFILE_DIR MAKEFILE_LIST
VARIABLES_TO_SHOW += PACKAGE PREFIX PROJECT PWD USER

# -- Directories -- #
BIN_DIR := bin/.
LOG_DIR := logs/.
SETUP_DIRS := $(BIN_DIR) $(LOG_DIR)


# ============================================================================ #
# INTERNAL VARIABLES
# ============================================================================ #

# -- Directories -- #

# Absolute path of the directory containing files to be included as part of a
# makefile set.
MAKEFILE_DIR = $(dir $(realpath $(MAKEFILE)))/.make

# -- Files -- #

# The name of the main makefile.
MAKEFILE = $(firstword $(MAKEFILE_LIST))

# -- Key/Value Pairs -- #

PROJECT_KV = project_name:$(PROJECT)
EMAIL_KV = email:$(EMAIL)
GITHUB_USER_KV = github_user:$(GITHUB_USER)
TRAVIS_USER_KV = travis_user:$(TRAVIS_USER)


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Main Phony Targets -- #

.PHONY: all build clean docs init test

all: help

ifneq ($(PROJECT),Makefile-Xcode)
## clean: Completes all cleaning activities.
clean: clean-git clean-xcode clean-github clean-common clean-dirs
endif

## debug: Completes all debugging activities.
debug: debug-vars-some debug-dirs-tree

## docs: Makes API documentation.
docs: docs-swift

## init: Completes all initial repo setup activities.
init: init-github init-xcode init-common init-git

## test: Completes all test activities.
test: test-xcode


# ============================================================================ #
# FEATURE DEPENDENCIES
# ============================================================================ #

include $(MAKEFILE_DIR)/features/formatting.mk

include $(MAKEFILE_DIR)/features/debugging.mk
include $(MAKEFILE_DIR)/features/downloading.mk
include $(MAKEFILE_DIR)/features/helping.mk

#include $(MAKEFILE_DIR)/features/common.mk


# ============================================================================ #
# PLATFORM DEPENDENCIES
# ============================================================================ #

#include $(MAKEFILE_DIR)/platforms/Cookiecutter.mk

include $(MAKEFILE_DIR)/platforms/Git.mk
include $(MAKEFILE_DIR)/platforms/GitHub.mk
include $(MAKEFILE_DIR)/platforms/Swift.mk
include $(MAKEFILE_DIR)/platforms/Xcode.mk
