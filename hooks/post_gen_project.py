#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = '0.0.0'

__author__ = 'Robert (Bob) L. Jones'
__credits__ = ['Robert (Bob) L. Jones']

__copyright__ = 'Copyright 2019, Cookiecutter Repo'
__license__ = 'MIT'

__created_date__= 'Aug 11, 2019'
__modified_date__= 'Aug 20, 2020'


# ============================================================================ #
# LIBRARIES
# ============================================================================ #

# -- Python Standard Library -- #

import json
import logging as log
import os
import sys

# -- 3rd-Party -- #

from cookiecutter.main import cookiecutter
from getpass import getpass
#from git import Repo
#from github import Github

#import pygit2
import requests
import sh

# ============================================================================ #
# CONSTANTS
# ============================================================================ #

# -- Debugging -- #

DEBUG = True

# -- Filesystem -- #

# Calling os.path.basename(__file__) generates filename (e.g.,tmp69w3m_kf.py).
# This is due to how Cookiecutter processes a template's hooks (i.e., Python
# scripts for handling any pre- or post-boilerplate generation.  So, hard-code
# the name of of the hook instead.
SCRIPT_NAME = 'post_gen_project.py'

# -- Input -- #

# Filesystem
LICENSE = '{{cookiecutter.repo_license}}'
REPO_DIR = '{{cookiecutter.repo_dir}}'

#PROJECT_PLATFORM = '{{cookiecutter.project_platform}}'
#print(f'PROJECT_PLATFORM={PROJECT_PLATFORM}')

# GitHub API v3
REPO_DESCRIPTION = '{{cookiecutter.repo_description}}'
REPO_NAME = '{{cookiecutter.repo_name}}'

GH_USER = '{{cookiecutter.github_user}}'

# -- Input Mappings -- #

LICENSE_TEMPLATES = {
    'private / not open source': '',
    'Academic Free License v3.0': 'afl-3.0',
    'Apache license 2.0': 'apache-2.0',
    'Artistic license 2.0': 'artistic-2.0',
    'Boost Software License 1.0': 'bsl-1.0',
    'BSD 2-clause "Simplified" license': 'bsd-2-clause',
    'BSD 3-clause "New" or "Revised" license': 'bsd-3-clause',
    'BSD 3-clause Clear license': 'bsd-3-clause-clear',
    'Creative Commons license family': 'cc',
    'Creative Commons Zero v1.0 Universal': 'cc0-1.0',
    'Creative Commons Attribution 4.0': 'cc-by-4.0',
    'Creative Commons Attribution Share Alike 4.0': 'cc-by-sa-4.0',
    'Do What The F*ck You Want To Public License': 'wtfpl',
    'Educational Community License v2.0': 'ecl-2.0',
    'Eclipse Public License 1.0': 'epl-1.0',
    'European Union Public License 1.1': 'eupl-1.1',
    'GNU Affero General Public License v3.0': 'agpl-3.0',
    'GNU General Public License family': 'gpl',
    'GNU General Public License v2.0': 'gpl-2.0',
    'GNU General Public License v3.0': 'gpl-3.0',
    'GNU Lesser General Public License family': 'lgpl',
    'GNU Lesser General Public License v2.1': 'lgpl-2.1',
    'GNU Lesser General Public License v3.0': 'lgpl-3.0',
    'ISC': 'isc',
    'LaTeX Project Public License v1.3c': 'lppl-1.3c',
    'Microsoft Public License': 'ms-pl',
    'MIT': 'mit',
    'Mozilla Public License 2.0': 'mpl-2.0',
    'Open Software License 3.0': 'osl-3.0',
    'PostgreSQL License': 'postgresql',
    'SIL Open Font License 1.1': 'ofl-1.1',
    'University of Illinois/NCSA Open Source License': 'ncsa',
    'The Unlicense': 'unlicense',
    'zLib License': 'zlib'
}

# -- Processed Input -- #

# Filesystem
repo_subdir = os.path.basename(REPO_DIR)

# GitHub API v3
IS_PRIVATE = True if LICENSE == 'Not open source' else False
LICENSE_TEMPLATE = LICENSE_TEMPLATES[LICENSE]
repo_name = repo_subdir.replace(' ', '-').replace('_', '-')

# -- Source Code Control (SCM) -- #

# GitHub API v3
GH_API_URL = 'https://api.github.com/user/repos'
GH_HOME_URL = 'https://github.com'


# ============================================================================ #
# FUNCTIONS
# ============================================================================ #

# -- Debugging -- #

def cmd(*args):
    """
    Execute shell commands that import `sh` can't.

    Args:
        *args: Variable length argument list.
    """

    os.system(' '.join(args))

def make(*args):
    cmd('make', *args)

def rm(*args):
    cmd('rm -rf', *args)

# -- Logging -- #

def setup_logging(is_verbose: bool):
    """
    Configure logging system.
    
    Args:
        is_verbose (bool): A boolean flag for setting log verbosity.
    """

    # For more info or inspiration on log formats, see:
    # https://alvinalexander.com/blog/post/java/sample-how-format-log4j-logging-logfile-output
    log_parts = [
        '%(levelname)-8s',
        '%(asctime)s',
        '%(module)s',
        '%(funcName)s',
        f'{SCRIPT_NAME}:%(lineno)d',
        '%(message)s'
    ]
    format = ' | '.join(log_parts)
    datefmt = '%Y-%m-%d %H:%M:%S'

    if is_verbose:
        DEBUG = True
        log.basicConfig(format=format, datefmt=datefmt, level=log.INFO)
        log.info('Logging verbosely...')
    else:
        log.basicConfig(format=format, datefmt=datefmt, level=log.WARNING)

# -- Source Code Control (SCM) -- #

def add_gh_repo(origin_url):
    """
    Add a GitHub repo to the local git repo, then syncs the two.
    """

    git = sh.git

    git.remote.add.origin(origin_url)
    git.push('-u', 'origin', 'master')

def create_file(file_path):
    """
    Create a file (from a repo's perspective).
    """

    git = sh.git
    filename = os.path.basename(file_path)

    git.add(file_path)
    git.commit(f'-m Create {filename}')

def create_gh_repo(repo_name):
#def create_gh_repo():
    """
    Create a GitHub repo.
    """

    gh_data_dict = {
        'name': repo_name,
        'description': REPO_DESCRIPTION,
        'private': IS_PRIVATE,
        'license_template': LICENSE_TEMPLATE
        }
    gh_data = json.dumps(gh_data_dict)
    gh_password = getpass('github_password: ')

    requests.post(
        GH_API_URL,
        data=gh_data,
        auth=(GH_USER, gh_password)
        )

def create_git_repo(repo_name):
#def create_git_repo():
    """
    Create a Git repo with a single file.
    """

    git = sh.git
    git.init()
    git.remote.add.origin(f'{GH_HOME_URL}/{GH_USER}/{repo_name}.git')

def add(cookiecutter_suffix, extra_context):
    """
    Create a repo from a cookiecutter.
    """

    cookiecutter(
        'gh:djrlj694/cookiecutter-%s' % cookiecutter_suffix,
        extra_context=extra_context,
        no_input=True,
        output_dir='..',
        overwrite_if_exists=True)   

# -- Main Program -- #

def main():
    """
    Run the main set of functions that define the program.
    """

    # Initialize project platforms.

    # Create repositories.
    create_gh_repo(REPO_NAME)
    create_git_repo(REPO_NAME)

    # Download files to local repository.
    sh.git.pull('origin', 'master')

    # Add files to local repository.
    create_file('README.md')
    create_file('.gitignore')

    # Upload (updated) files to remote repository.
    sh.git.push('-u', 'origin', 'master')

    #pass


# ============================================================================ #
# MAIN EXECUTION
# ============================================================================ #

# -- Debugging -- #

if DEBUG:
    cmd('echo PWD=$PWD')
    cmd('which python')
    cmd('python --version')
    cmd('conda list')
    cmd('pip list')
    print(f'REPO_DIR={REPO_DIR}')
    print(f'REPO_NAME={REPO_NAME}')
    print(f'repo_name={repo_name}')

# -- Source Code Control (SCM) -- #

extra_context = {'project_name': '{{cookiecutter.repo_name}}'}

#if PROJECT_PLATFORM == 'Swift':
#    print(f'swift_package_type={swift_package_type}')
#    make(f'init-swift SWIFT_PROJECT_TYPE="{PROJECT_PLATFORM}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')
#elif PROJECT_PLATFORM == 'Xcode':
#    cmd('open -a Xcode')
#    print(f'swift_package_type={swift_package_type}')
#    make(f'init-xcode SWIFT_PROJECT_TYPE="{PROJECT_PLATFORM}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')

make('init')
rm('.boilerplate')

# -- Main Execution -- #

# If this module is in the main module, call the main() function.
if __name__ == "__main__":
    main()

# -- Housekeeping -- #

# Exit the program normally.
sys.exit(0)
