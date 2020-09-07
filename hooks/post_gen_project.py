#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = '0.0.0'

__author__ = 'Robert (Bob) L. Jones'
__credits__ = ['Robert (Bob) L. Jones']

__copyright__ = 'Copyright 2019, Cookiecutter Repo'
__license__ = 'MIT'

__created_date__= 'Aug 11, 2019'
__modified_date__= 'Sep 07, 2020'


# ============================================================================ #
# IMPORTS
# ============================================================================ #

# -- Python Standard Library -- #

import json
import logging as log
import os
import sys

# -- 3rd-Party -- #

from cookiecutter.main import cookiecutter
#from getpass import getpass

# ============================================================================ #
# CONSTANTS
# ============================================================================ #

# -- Debugging -- #

DEBUG = False

# -- Filesystem -- #

# Directories
BP_DIR = '.boilerplate'

# Calling os.path.basename(__file__) generates filename (e.g.,tmp69w3m_kf.py).
# This is due to how Cookiecutter processes a template's hooks (i.e., Python
# scripts for handling any pre- or post-boilerplate generation.  So, hard-code
# the name of of the hook instead.
SCRIPT = 'post_gen_project.py'

# -- Input -- #

# Filesystem
LICENSE = '{{cookiecutter.repo_license}}'

#PLATFORM = '{{cookiecutter.project_platform}}'
#print('PLATFORM =', {PLATFORM})

# GitHub API v3
DESCRIPTION = '{{cookiecutter.project_description}}'
GH_USER = '{{cookiecutter.github_user}}'
PRIVATE = '{{cookiecutter.repo_private}}'

# Project
NAME = '{{cookiecutter.project_name}}'
TYPE = '{{cookiecutter.project_type}}'
PLATFORM = '{{cookiecutter.project_platform}}'
#project_version = '{cookiecutter.project_version}'
project_version = '___VERSION___'

# -- Input Mappings -- #

LICENSE_TEMPLATES = {
    'unspecified': '',
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

PROJECT_TYPES = {
    'Python': {
        'command-line interface': '',
        'data science': '',
        'library': '',
        'script': ''
    },
    'Swift': {
        'command-line interface': 'executable',
        'library': 'library'
    }
}


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

def cat(*args):
    cmd('cat', *args)

def cp(*args):
    cmd('cp -R', *args)

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
        f'{SCRIPT}:%(lineno)d',
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

# -- Main Program -- #

def main():
    """
    Run the main set of functions that define the program.
    """

    # Process input.
    license_template = LICENSE_TEMPLATES[LICENSE]
    project_type = PROJECT_TYPES[PLATFORM][TYPE]

    # Initialize project platforms.

    #if PLATFORM == 'Swift':
    #    print(f'swift_package_type={swift_package_type}')
    #    make(f'init-swift PROJECT_TYPE="{PLATFORM}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')
    #elif PLATFORM == 'Xcode':
    #    cmd('open -a Xcode')
    #    print(f'swift_package_type={swift_package_type}')
    #    make(f'init-xcode PROJECT_TYPE="{PLATFORM}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')

    make(
        'init',
        f'USER={GH_USER} DESCRIPTION={DESCRIPTION}',
        f'PRIVATE={PRIVATE} LICENSE_TEMPLATE={license_template}',
        f'PACKAGE={NAME} PROJECT_TYPE={project_type}'
        )

    # TODO: Uncomment this line.
    #rm(BP_DIR)


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

# -- Main Execution -- #

# If this module is in the main module, call the main() function.
if __name__ == "__main__":
    main()

# -- Housekeeping -- #

# Exit the program normally.
sys.exit(0)
