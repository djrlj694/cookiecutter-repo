# {{ cookiecutter.repo_name }}

[![Build Status](https://travis-ci.org/{{ cookiecutter.travis_user }}/TravisCIBlog.svg?branch=master)](https://travis-ci.org/{{ cookiecutter.travis_user }}/{{ cookiecutter.project_name }})

## Usage

{{ cookiecutter.repo_usage }}

## Options

{{ cookiecutter.repo_options }}

## System Requirements

{{ cookiecutter.repo_requirements }}

## Installation

{{ cookiecutter.repo_installation }}

## Documentation

Documentation for the project can be found [here](https://{{ cookiecutter.github_user }}.github.io/{{ cookiecutter.repo_name }}/).

## Known Issues

Currently, there are no known issues.{% if cookiecutter.add_github %}  If you discover any, please kindly submit a [pull request](CONTRIBUTING.md).{% endif %}

{% if cookiecutter.add_github %}
## Contributing

Code and codeless (e.g., documentation) contributions toward improving {{ cookiecutter.repo_name }} are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to become a contributor.
{% endif %}

{% if cookiecutter.repo_license != 'Not open source' %}
## License

{{ cookiecutter.repo_name }} is released under the [{{ cookiecutter.repo_license }}](LICENSE.md).
{% endif %}

## References

See [REFERENCES.md](REFERENCES.md) for a list of sources that I found helpful or inspirational when learning new topics, troubleshooting bugs, authoring documentation, etc.
