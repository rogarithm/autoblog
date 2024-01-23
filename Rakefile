require_relative './lib/autoblog.rb'

task :default => [:clean, :publish]

task :publish do
  FileUtils.mkdir(File.join(File.dirname(__FILE__), *%w[dest]))
  AutoBlog.process(
    File.join(File.dirname(__FILE__), *%w[source]),
    File.join(File.dirname(__FILE__), *%w[dest]),
  )
end

task :clean do
  FileUtils.remove_dir(File.join(File.dirname(__FILE__), *%w[dest]))
end
