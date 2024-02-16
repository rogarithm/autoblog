require_relative './lib/autoblog.rb'
require 'rake/clean'

task :default => [:publish]

task :publish => [:clean] do
  AutoBlog.process(
    File.join(File.dirname(__FILE__), *%w[source]),
    File.join(File.dirname(__FILE__), *%w[dest]),
  )
end

task :clean do
  html_pat = File.join(File.dirname(__FILE__), *%w[dest], "*.html")
  html_files = Dir.glob(html_pat)
  FileUtils.rm(html_files)

  css_pat = File.join(File.dirname(__FILE__), *%w[dest css])
  css_dir = Dir.glob(css_pat)
  FileUtils.rm_rf(css_dir)
end

task :test_token do
  Dir.glob('./lib/autoblog/converter/tokenizer/**/*.rb').each do |file|
    require file
  end
  Dir.glob('./spec/test_token*.rb').each do |file|
    require file
  end
end
task :test_parser do
  require './lib/autoblog/converter/parser/parsers/parser_factory.rb'
  Dir.glob('./lib/autoblog/converter/**/*.rb').each.with_index do |file|
    require file
  end
  Dir.glob('./spec/test_parser.rb').each do |file|
    require file
  end
end
