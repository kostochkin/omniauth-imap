$:.push File.expand_path("lib", __dir__)

require "omniauth-imap/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-imap"
  s.version     = OmniAuth::IMAP::VERSION
  s.authors     = ["Konstantin Gorshkov"]
  s.email       = ["k.n.gorshkovk@gmail.com"]
  s.homepage    = "https://github.com/kostochkin/omniauth-imap"
  s.license     = "MIT"
  s.summary     = "An IMAP strategy for OmniAuth."
  s.description = "An OmniAuth strategy to allow you to authenticate " \
                  "against IMAP."

  s.files         = `git ls-files`.split($RS)
  s.executables   = s.files.grep(/^exe/) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'omniauth', '~> 1.5'

end
