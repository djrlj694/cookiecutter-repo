Pod::Spec.new do |spec|
    spec.name = "{{cookiecutter.project_name}}"
    spec.version = "1.0.0"
    spec.summary = "{{cookiecutter.project_short_description}}"
    spec.homepage = "https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.project_name}}"
    spec.license = { type: '{{cookiecutter.repo_license}}', file: 'LICENSE' }
    spec.authors = { "{{cookiecutter.lead_name}}" => '{{cookiecutter.team_email}}' }
    spec.social_media_url = "http://twitter.com/{{cookiecutter.github_user}}"
  
    spec.platform = :ios, "12.1"
    spec.requires_arc = true
    spec.source = { git: "https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.project_name}}.git", tag: "v#{spec.version}", submodules: true }
    spec.source_files = "{{cookiecutter.project_name}}/*/*.{h,swift}"
end
  