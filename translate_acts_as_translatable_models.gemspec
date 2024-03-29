Gem::Specification.new do |s|
  s.name = "translate_acts_as_translatable_models"
  s.version = "0.0.9"

  s.author = "Lasse Bunk"
  s.email = "lassebunk@gmail.com"
  s.description = "Ruby on Rails plugin for easy translation of your acts_as_translatable models."
  s.summary = "Ruby on Rails plugin for easy translation of your acts_as_translatable models."
  s.homepage = "http://github.com/lassebunk/translate_acts_as_translatable_models"
  s.add_dependency "bing_translator", "~> 0.0.2"
  s.files = Dir['lib/**/*']
  s.require_paths = ["lib"]
end