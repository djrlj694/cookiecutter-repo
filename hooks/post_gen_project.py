#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'Robert (Bob) L. Jones'
__coauthor__ = 'N/A'
__copyright__ = 'Copyright 2019, Cookiecutter-Repo'
__credits__ = ['Robert (Bob) L. Jones']
__license__ = 'MIT'
__version__ = '0.0.1'
__maintainer__ = 'Robert (Bob) L. Jones'
__email__ = 'djrlj694@gmail.com'
__status__ = 'Development'
__created_date__= 'Aug 11, 2019'
__modified_date__= 'Aug 19, 2019'

#==============================================================================#
# LIBRARIES
#==============================================================================#

##----------------------------------------------------------------------------##
## 3rd-party
##----------------------------------------------------------------------------##

import json
import os
import requests
import sh
import sys

from cookiecutter.main import cookiecutter
from getpass import getpass

#==============================================================================#
# CONSTANTS
#==============================================================================#

##----------------------------------------------------------------------------##
## Debugging
##----------------------------------------------------------------------------##

DEBUG = False

##----------------------------------------------------------------------------##
## Version Control
##----------------------------------------------------------------------------##

GH_API_URL = 'https://api.github.com/user/repos'
GH_HOME_URL = 'https://github.com'

#==============================================================================#
# VARIABLES
#==============================================================================#

##----------------------------------------------------------------------------##
## Input
##----------------------------------------------------------------------------##

### Filesystem

repo_dir = '{{ cookiecutter.repo_dir }}'

repo_platform = '{{ cookiecutter.repo_platform }}'
repo_platform_parts = repo_platform.lower().split()
platform = repo_platform_parts[0]
print(f'repo_platform={repo_platform}, platform={platform}')

### GitHub API v3

repo_description = '{{ cookiecutter.repo_description }}'
repo_license_template = '{{ cookiecutter.repo_license_template }}'
repo_private = '{{ cookiecutter.repo_private }}'

gh_user = '{{ cookiecutter.github_user }}'

##----------------------------------------------------------------------------##
## Processed Input
##----------------------------------------------------------------------------##

### Filesystem

repo_subdir = os.path.basename(repo_dir)

### GitHub API v3

repo_name = repo_subdir.replace(' ', '-').replace('_', '-')

#==============================================================================#
# FUNCTIONS
#==============================================================================#

##----------------------------------------------------------------------------##
## Debugging
##----------------------------------------------------------------------------##

### Executes shell commands that the "sh" module can't.

def cmd(*args):
    os.system(' '.join(args))

def make(*args):
    cmd('make', *args)

def rm(*args):
    cmd('rm -rf', *args)

##----------------------------------------------------------------------------##
## Version Control 
##----------------------------------------------------------------------------##

### Adds a GitHub repo to the local git repo, then syncs the two.

def add_gh_repo(origin_url):

    git = sh.git

    git.remote.add.origin(origin_url)
    git.push('-u', 'origin', 'master')

### Creates a file (from a repo's perspective).

def create_file(file_path):

    git = sh.git
    filename = os.path.basename(file_path)

    git.add(file_path)
    git.commit(f'-m Create {filename}')

### Creates a GitHub repo.

def create_gh_repo():

    gh_data_dict = {
        'name': repo_name,
        'description': repo_description,
        'private': repo_private,
        'license_template': repo_license_template
        }
    gh_data = json.dumps(gh_data_dict)
    gh_password = getpass('github_password: ')

    requests.post(
        GH_API_URL,
        data=gh_data,
        auth=(gh_user, gh_password)
        )

### Creates a Git repo with a single file.

def create_git_repo():
    git = sh.git
    git.init()
    git.remote.add.origin(f'{GH_HOME_URL}/{gh_user}/{repo_name}.git')

# Create a repo from a cookiecutter.

def add(cookiecutter_suffix, extra_context):
    cookiecutter(
        'gh:djrlj694/cookiecutter-%s' % cookiecutter_suffix,
        extra_context=extra_context,
        no_input=True,
        output_dir='..',
        overwrite_if_exists=True)   

#==============================================================================#
# MAIN PROGRAM
#==============================================================================#

##----------------------------------------------------------------------------##
## Debugging
##----------------------------------------------------------------------------##

if DEBUG:
    cmd('echo PWD=$PWD')
    cmd('conda list')
    cmd('pip list')
    cmd('python --version')
    print(f'repo_dir={repo_dir}')
    print(f'repo_subdir={repo_subdir}')
    print(f'repo_name={repo_name}')

##----------------------------------------------------------------------------##
## Version Control 
##----------------------------------------------------------------------------##

extra_context = {'project_name': '{{ cookiecutter.repo_name }}'}

if platform == 'swift':
    swift_package_type = repo_platform_parts[1]
    print(f'swift_package_type={swift_package_type}')
    make(f'init-swift SWIFT_PROJECT_TYPE="{repo_platform}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')
elif platform == 'xcode':
    cmd('open -a Xcode')
    swift_package_type = repo_platform_parts[1]
    print(f'swift_package_type={swift_package_type}')
    make(f'init-xcode SWIFT_PROJECT_TYPE="{repo_platform}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')

#rm('.boilerplate')

##----------------------------------------------------------------------------##
## Housekeeping
##----------------------------------------------------------------------------##

sys.exit(0)
