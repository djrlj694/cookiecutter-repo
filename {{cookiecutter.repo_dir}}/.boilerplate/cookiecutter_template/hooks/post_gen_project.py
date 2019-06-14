#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = '{{ cookiecutter.lead_name }}'
__coauthor__ = 'N/A'
__copyright__ = 'Copyright {% now 'local', '%Y' %}, {{ cookiecutter.repo_name }}'
__credits__ = ['{{ cookiecutter.lead_name }}']
__license__ = '{{ cookiecutter.repo_license }}'
__version__ = '0.0.1'
__maintainer__ = '{{ cookiecutter.lead_name }}'
__email__ = '{{ cookiecutter.lead_email }}'
__status__ = 'Development'
__created_date__= '{% now 'local', '%b %d, %Y' %}'
__modified_date__= '{% now 'local', '%b %d, %Y' %}'

### Libraries ###

# 3rd-party

import os
import sys

from cookiecutter.main import cookiecutter

### Variable Declarations ###

### Function Declarations ###

### Main Program ###

sys.exit(0)
