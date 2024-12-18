# frozen_string_literal: true

require_relative 'lib/curp_generator/version'

Gem::Specification.new do |spec|
  spec.name     = 'curp_generator'
  spec.version  = CurpGenerator::VERSION
  spec.licenses = ['MIT']
  spec.authors  = ['Juan Carlos Estebes', 'Manuel de la Torre']
  spec.summary  = 'Generates a mexican CURP given the information of a person'
  spec.homepage = 'https://github.com/yotepresto-com/curp-generator'
  spec.required_ruby_version = '>= 2.6'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata = {
    'rubygems_mfa_required' => 'true',
    'homepage_uri'          => spec.homepage,
    'source_code_uri'       => 'https://github.com/yotepresto-com/curp-generator',
    'changelog_uri'         => 'https://github.com/yotepresto-com/curp-generator/blob/main/CHANGELOG.md'
  }

  spec.files = Dir['lib/**/*']
end
