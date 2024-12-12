require_relative './lib/autoblog.rb'
require 'rake/clean'
require 'rspec/core/rake_task'

task :default => [:draft]

task :draft => [:clean_draft] do
  draft_dir = File.join(*%w[/ tmp drafts])
  FileUtils.mkdir_p draft_dir if !Dir.exist?(draft_dir)

  AutoBlog.process(
    File.join(File.dirname(__FILE__), *%w[source]),
    draft_dir,
    :draft
  )

  puts "you can check your drafts in #{draft_dir}"
end

task :clean_draft do
  draft_dir = File.join(*%w[/ tmp drafts])
  FileUtils.rm_r draft_dir if Dir.exist?(draft_dir)
end

task :publish => [:clean] do
  publish_dir = File.join(File.dirname(__FILE__), *%w[dest])

  AutoBlog.process(
    File.join(File.dirname(__FILE__), *%w[source]),
    publish_dir,
    :publish
  )

  puts "you can check your posts in #{publish_dir}"
end

task :clean do
  html_pat = File.join(File.dirname(__FILE__), *%w[dest *.html])
  html_files = Dir.glob(html_pat)
  FileUtils.rm(html_files)

  css_pat = File.join(File.dirname(__FILE__), *%w[dest css])
  css_dir = Dir.glob(css_pat)
  FileUtils.rm_rf(css_dir)
end
