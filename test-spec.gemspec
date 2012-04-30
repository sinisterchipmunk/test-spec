# -*- encoding: utf-8 -*-

spec = Gem::Specification.new do |s|
  s.name            = "test-spec"
  s.version         = "1.0"
  s.platform        = Gem::Platform::RUBY
  s.summary         = "a Behaviour Driven Development interface for Test::Unit"
  s.description = <<-EOF
test/spec layers an RSpec-inspired interface on top of Test::Unit, so
you can mix TDD and BDD (Behavior-Driven Development).

test/spec is a clean-room implementation that maps most kinds of
Test::Unit assertions to a `should'-like syntax.
  EOF

  s.files           = `git ls-files`.split(/\n/)
  s.bindir          = 'bin'
  s.executables     << 'specrb'
  s.require_path    = 'lib'
  s.has_rdoc        = true
  s.extra_rdoc_files = ['README.rdoc', 'SPECS', 'ROADMAP']
  s.test_files      = Dir['test/{test,spec}_*.rb']

  s.author          = 'Christian Neukirchen'
  s.email           = 'chneukirchen@gmail.com'
  s.homepage        = "http://test-spec.rubyforge.org"
  s.rubyforge_project = 'test-spec'
  s.add_dependency "test-unit"
end
