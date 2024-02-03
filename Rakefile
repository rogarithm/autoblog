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
end
