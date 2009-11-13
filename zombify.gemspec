# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{zombify}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Studio Melipone"]
  s.date = %q{2009-11-13}
  s.description = %q{Zombifies strings in your application.}
  s.email = %q{contact@studiomelipone.eu}
  s.extra_rdoc_files = ["README.rdoc", "lib/rand.rb", "lib/zombify.rb"]
  s.files = ["Manifest", "README.rdoc", "Rakefile", "lib/rand.rb", "lib/zombify.rb", "zombify.gemspec"]
  s.homepage = %q{http://github.com/jbfeldis/zombify}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Zombify", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{zombify}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Zombifies strings in your application.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
