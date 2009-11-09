Gem::Specification.new do |s|
  s.name = %q{url_shortener}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nasir Jamal"]
  s.date = %q{2009-11-09}
  s.description = %q{Url Shortener is a Ruby library /gem and API wrapper for bit.ly}
  s.email = %q{nas35_in@yahoo.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["History.txt",
             "Manifest.txt",
             "README.rdoc",
             "lib/url_shortener.rb",
             "lib/url_shortener/authorize.rb",
             "lib/url_shortener/client.rb",
             "lib/url_shortener/error.rb",
             "lib/url_shortener/interface.rb"
             ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nas/url_shortener}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Url Shortener is a Ruby library /gem and API wrapper for bit.ly}
  s.test_files = ["spec/spec_helper.rb",
                  "spec/url_shortener/authorize_spec.rb",
                  "spec/url_shortener/client_spec.rb",
                  "spec/url_shortener/interface_spec.rb",
                  "features/connect_to_bitly.feature",
                  "features/short_url.feature",
                  "features/support/env.rb",
                  "features/step_definitions/connection_error_steps.rb",
                  "features/step_definitions/short_url_steps.rb"
                 ]
  s.platform = Gem::Platform::RUBY 
  s.required_ruby_version = '>=1.8'
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
    
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.5"])
    else
      s.add_dependency(%q<httparty>, [">= 0.4.5"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.4.5"])
  end
end
