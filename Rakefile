require_relative './lib/autoblog.rb'
require 'rake/clean'
require 'rspec/core/rake_task'

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
