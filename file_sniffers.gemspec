lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'file_sniffers'
  spec.version       = '0.1.0'
  spec.authors       = ['Premysl Donat']
  spec.email         = ['pdonat@seznam.cz']

  spec.summary       = 'A bunch of file sniffers for detecting various properties of different files.'
  spec.description   = spec.description
  spec.homepage      = 'https://github.com/Masa331/file_sniffers'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
end
