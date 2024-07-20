require_relative 'post'
require 'fileutils'

module AutoBlog
  class Site
    attr_accessor :posts, :urls

    def initialize(path)
      @posts = []
      @urls = {}
      Dir["#{path}/*.md"].each do |full_path|
        md_file = full_path.split("/")[-1]
        post = Post.new(path, md_file)
        @posts << post
        @urls[md_file.split(".").first] = post.url
      end
    end

    def process(path)
      @posts.each do |post|
        post.write(path)
      end
      write_index path
      copy_static_info
    end

    def post_title post
      post.meta_info.sub(/^title: /, '')
    end

    def write_index path
      template_path = File.join(File.dirname(__FILE__), *%w[.. layout index.html])
      stylesheet_path = File.join(File.dirname(__FILE__), *%w[.. css index.css])

      content = "<ul>"
      @urls.keys.each.with_index do |key, index|
        current_post = posts[index]
        if posts[index].meta_info != nil
          title = post_title current_post
        else
          title = key
        end
        content.concat("<li>
                       <span>2024/07/19</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#{@urls[key]}\">#{title}</a></br>
                       </li>")
      end
      content.concat("</ul>")

      b = binding
      b.local_variable_set(:converted, content)
      b.local_variable_set(:style, stylesheet_path)
      template = ERB.new(File.read(template_path)).result(b)

      dest_path = File.join(path, "index.html")
      File.open(dest_path, 'w') do |f|
        f.write(template)
      end
      path
    end

    def copy_static_info
      # make css directory, and copy every .css files in source to css directory
      FileUtils.cp_r(
        File.join(File.dirname(__FILE__), *%w[.. .. lib css]),
        File.join(File.dirname(__FILE__), *%w[.. .. dest css])
      )
      # make font directory, and copy every font files
      FileUtils.cp_r(
        File.join(File.dirname(__FILE__), *%w[.. .. lib fonts]),
        File.join(File.dirname(__FILE__), *%w[.. .. dest fonts])
      )
    end
  end
end
