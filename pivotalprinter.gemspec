# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pivotalprinter}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["pkw.dev"]
  s.date = %q{2010-12-07}
  s.default_executable = %q{pivotalprinter}
  s.description = %q{FIX (describe your package)}
  s.email = ["dev@pkw.de"]
  s.executables = ["pivotalprinter"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "bin/pivotalprinter", "images/bug.png", "images/chore.png", "images/feature.png", "images/release.png", "lib/pivotalprinter.rb", "pivotalprinter.gemspec", "script/console", "script/destroy", "script/generate", "stories.pdf", "test/test_helper.rb", "test/test_pivotalprinter.rb"]
  s.homepage = %q{http://github.com/#{github_username}/#{project_name}}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pivotalprinter}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{FIX (describe your package)}
  s.test_files = ["test/test_helper.rb", "test/test_pivotalprinter.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pivotal-tracker>, [">= 0.3"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 0.4.4"])
      s.add_runtime_dependency(%q<prawn>, [">= 0.8.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.2"])
    else
      s.add_dependency(%q<pivotal-tracker>, [">= 0.3"])
      s.add_dependency(%q<term-ansicolor>, [">= 0.4.4"])
      s.add_dependency(%q<prawn>, [">= 0.8.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<pivotal-tracker>, [">= 0.3"])
    s.add_dependency(%q<term-ansicolor>, [">= 0.4.4"])
    s.add_dependency(%q<prawn>, [">= 0.8.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.2"])
  end
end
