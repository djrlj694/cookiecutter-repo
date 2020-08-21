# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: GitHub.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 23FEB2019
# REVISED: 18AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

GITHUB_USER := $(USER)
TRAVIS_USER := $(USER)

EMAIL := $(USER)@gmail.com


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisites for "clean" Target -- #

.PHONY: clean-github clean-docs-github 

## clean-github: Completes all GitHub cleanup activities.
clean-github: clean-docs-github

## clean-docs-github: Completes all GitHub Markdown cleanup activities.
clean-docs-github: | $(LOG)
	@printf "Removing GitHub documents..."
	@rm -rf .github >$(LOG) 2>&1; \
	$(status_result)

# -- Prerequisite for "init" Target -- #

.PHONY: init-github

## init-github: Completes all initial Github setup activites.
init-github:
	@printf "Initializing GitHub repository..."
	$(eval gh_api_url = https://api.github.com/user/repos)
	$(eval PROJECT_REPO = $(GITHUB_USER)/$(PROJECT))
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/cookiecutter-github)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
	$(eval ORIGIN_URL = https://github.com/$(PROJECT_REPO).git)
#	@cookiecutter gh:$(TEMPLATES_REPO) email=$(EMAIL) project_name=$(PROJECT)
#	@curl -H "Authorization: token $(GITHUB_API_TOKEN)" https://api.github.com/user/repos -d '{"name": "'"${NEW_REPO_NAME}"'"}'
#	@curl -H "Authorization: token $(GITHUB_API_TOKEN)" $(gh_api_url) \
#	-d '{"name": "'"${PROJECT}"'", "name": "'"${PROJECT}"'"}' >$(LOG) 2>&1; \
#	$(status_result)

# GitHub API v3
#GH_API_URL = 'https://api.github.com/user/repos'
#GH_HOME_URL = 'https://github.com'

#def create_gh_repo(repo_name):
#def create_gh_repo():
#    """
#    Create a GitHub repo.
#    """
#
#    gh_data_dict = {
#        'name': repo_name,
#        'description': REPO_DESCRIPTION,
#        'private': IS_PRIVATE,
#        'license_template': LICENSE_TEMPLATE
#        }
#    gh_data = json.dumps(gh_data_dict)
#    gh_password = getpass('github_password: ')

#    requests.post(
#        GH_API_URL,
#        data=gh_data,
#        auth=(GH_USER, gh_password)
#        )

