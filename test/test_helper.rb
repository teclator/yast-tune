ENV["Y2DIR"] = File.expand_path("../../src", __FILE__)

require "yast"

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/spec/"
  end

  # for coverage we need to load all ruby files
  src_location = File.expand_path("../../src", __FILE__)
  Dir["#{src_location}/{modules,lib}/**/*.rb"].each { |f| require_relative f }

  # use coveralls for on-line code coverage reporting at Travis CI
  if ENV["TRAVIS"]
    require "coveralls"
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  end
end
