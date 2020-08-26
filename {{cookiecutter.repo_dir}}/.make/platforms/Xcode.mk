# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Xcode.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 04FEB2019
# REVISED: 25AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Filesystem -- #

XCODE_RESOURCES := Data Fonts Localization Media UserInterfaces
XCODE_RESOURCES_DIRS := $(addprefix $(PACKAGE)/Resources/,$(XCODE_RESOURCES))

XCODE_SOURCES := Controllers Extensions Models Protocols ViewModels Views
XCODE_SOURCES_DIRS := $(addprefix $(PACKAGE)/Sources/,$(XCODE_SOURCES))

XCODE_DIRS := $(addsuffix /.,$(XCODE_RESOURCES_DIRS) $(XCODE_SOURCES_DIRS))
#XCODE_DIRS := $(XCODE_RESOURCES_DIRS) $(XCODE_SOURCES_DIRS)

# -- Help Strings -- #

# Argument syntax for the "make" command when used with this makefile.
MAKE_ARGS += [PACKAGE=$(FG_CYAN)<package>$(RESET)]
MAKE_ARGS += [PREFIX=$(FG_CYAN)<prefix>$(RESET)]
MAKE_ARGS += [USER=$(FG_CYAN)<user>$(RESET)]


# ============================================================================ #
# MACROS
# ============================================================================ #

# -- Test Strings -- #

define XCODE_DIRS_TEST
.
./.git
./.github
./.github/ISSUE_TEMPLATE
./.github/PULL_REQUEST_TEMPLATE
./$(PACKAGE)
./$(PACKAGE)/Resources
./$(PACKAGE)/Resources/Data
./$(PACKAGE)/Resources/Fonts
./$(PACKAGE)/Resources/Localization
./$(PACKAGE)/Resources/Media
./$(PACKAGE)/Resources/UserInterfaces
./$(PACKAGE)/Sources
./$(PACKAGE)/Sources/Controllers
./$(PACKAGE)/Sources/Extensions
./$(PACKAGE)/Sources/Models
./$(PACKAGE)/Sources/Protocols
./$(PACKAGE)/Sources/ViewModels
./$(PACKAGE)/Sources/Views
endef
export XCODE_DIRS_TEST

define XCODE_FILES_TEST
./.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE.md
./.github/ISSUE_TEMPLATE/bug_report.md
./.github/ISSUE_TEMPLATE/custom.md
./.github/ISSUE_TEMPLATE/feature_request.md
./.github/PULL_REQUEST_TEMPLATE/pull_request_template.md
./.gitignore
./CHANGELOG.md
./CODE_OF_CONDUCT.md
./CONTRIBUTING.md
./Cartfile
./Cartfile.private
./Framework.podspec
./README.md
./REFERENCES.md
./SUPPORT.md
endef
export XCODE_FILES_TEST


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisites for "clean" Target -- #

#.PHONY: clean-xcode clean-xcode-dirs clean-docs-xcode
.PHONY: clean-xcode clean-xcode-dirs

#clean-xcode: clean-docs-xcode ## Completes all Xcode cleanup activities.
clean-xcode: clean-carthage clean-cocoapods clean-xcode-dirs
	@printf "Removing Xcode setup..."
	@rm -rf $(PACKAGE) >$(LOG) 2>&1; \
	$(status_result)

# -- Prerequisites for "init" Target -- #

.PHONY: init-xcode init-xcode-dirs init-xcode-vars

## init-xcode: Completes all initial Xcode setup activites.
ifeq ($(COOKIECUTTER),)
init-xcode: init-xcode-vars init-xcode-dirs init-carthage init-cocoapods
else
init-xcode: init-xcode-vars
	@cookiecutter gh:$(TEMPLATES_REPO) project_name=$(REPO_NAME)
endif

## init-xcode-dirs: Completes all initial Xcode directory setup activites.
init-xcode-dirs: $(XCODE_DIRS)

## init-xcode-vars: Completes all Xcode variable setup activites.
init-xcode-vars:
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/Cookiecutter-Xcode)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)

# -- Prerequisites for "test" Target -- #

.PHONY: test-xcode test-xcode-dirs test-xcode-files

## test-xcode: Completes all Xcode test activites.
test-xcode: test-xcode-dirs test-xcode-files

## test-xcode-dirs: Test Xcode directory setup.
test-xcode-dirs: expected_xcode_dirs.txt actual_xcode_dirs.txt | $(LOG)
	@printf "Testing Xcode directory setup..."
	@diff expected_xcode_dirs.txt actual_xcode_dirs.txt >$(LOG) 2>&1; \
	$(test_result)

## test-xcode-files: Test Xcode file setup.
test-xcode-files: expected_xcode_files.txt actual_xcode_files.txt | $(LOG)
	@printf "Testing Xcode file setup..."
	@diff expected_xcode_files.txt actual_xcode_files.txt >$(LOG) 2>&1; \
	$(test_result)


# ============================================================================ #
# INTERMEDIATE TARGETS
# ============================================================================ #

.INTERMEDIATE: actual_xcode_dirs.txt actual_xcode_files.txt expected_xcode_dirs.txt expected_xcode_files.txt

# Makes a temporary file listing expected.
actual_xcode_dirs.txt:
#	@printf "Making file $(target_var).\n"
	@find . -type d -not -path "./.git/*" | sort >$@

# Makes a temporary file listing expected.
actual_xcode_files.txt:
#	@printf "Making file $(target_var).\n"
	@find . -type f -not \( -path "./.git/*" -or -path "./make.log" -or -path "./*_dirs.txt" -or -path "./*_files.txt" \) | sort >$@

# Makes a temporary file listing expected.
expected_xcode_dirs.txt:
#	@printf "Making file $(target_var).\n"
	@echo "$$XCODE_DIRS_TEST" >$@

# Makes a temporary file listing expected.
expected_xcode_files.txt:
#	@printf "Making file $(target_var).\n"
	@echo "$$XCODE_FILES_TEST" >$@


# ============================================================================ #
# PLATFORM DEPENDENCIES
# ============================================================================ #

include $(MAKEFILE_DIR)/platforms/Carthage.mk
include $(MAKEFILE_DIR)/platforms/CocoaPods.mk
include $(MAKEFILE_DIR)/platforms/Swift.mk
