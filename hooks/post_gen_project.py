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
__created_date__= 'May 27, 2019'
__modified_date__= 'Jul 25, 2019'

### Libraries ###

# 3rd-party

import os
import sys

from cookiecutter.main import cookiecutter

### Variable Declarations ###

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

repo_platform = '{{ cookiecutter.repo_platform }}'
repo_platform_parts = repo_platform.lower().split()
platform = repo_platform_parts[0]
print(f'repo_platform={repo_platform}, platform={platform}')

### Function Declarations ###

def cmd(*args):
    os.system(' '.join(args))

def make(*args):
    cmd('make', *args)

def rm(*args):
    cmd('rm -rf', *args)

# Create a repo from a cookiecutter.
def add(cookiecutter_suffix, extra_context):
    cookiecutter(
        'gh:djrlj694/cookiecutter-%s' % cookiecutter_suffix,
        extra_context=extra_context,
        no_input=True,
        output_dir='..',
        overwrite_if_exists=True)   

### Main Program ###

extra_context = {'project_name': '{{ cookiecutter.repo_name }}'}

#if {{ cookiecutter.add_github }}:
#    add('github', extra_context)
#
#if {{ cookiecutter.add_make }}:
#    add('makefile', extra_context)

if platform == 'swift':
    swift_package_type = repo_platform_parts[1]
    print(f'swift_package_type={swift_package_type}')
    make(f'init-swift SWIFT_PROJECT_TYPE="{repo_platform}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')
###    cmd('cp -R .boilerplate/swift_package/* .')
#    add(platform, extra_context)
#elif platform in ['ios', 'ipados', 'macos', 'tvos', 'watchos', 'xcode']:
elif platform == 'xcode':
    cmd('open -a Xcode')
    swift_package_type = repo_platform_parts[1]
    print(f'swift_package_type={swift_package_type}')
    make(f'init-xcode SWIFT_PROJECT_TYPE="{repo_platform}" SWIFT_PACKAGE_TYPE="{swift_package_type}"')
#    add('xcode', extra_context)
#elif platform in ['cookiecutter', 'github', 'makefile']:
#    add(platform, extra_context)

rm('.boilerplate')

sys.exit(0)
