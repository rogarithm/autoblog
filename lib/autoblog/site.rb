require_relative 'post'
require 'fileutils'
require 'date'

module AutoBlog
  class Site
    attr_accessor :posts, :urls

    def initialize(path)
      @posts = []
      Dir["#{path}/*.md"].each do |full_path|
        md_file = full_path.split("/")[-1]
        post = Post.new(path, md_file)
        @posts << post
      end
    end

    def process dest_path, publish_type
      posts2proc = @posts
      if publish_type == :publish
        posts2proc = posts2proc
                       .select {|p| p.is_draft? == false}
      end

      posts2proc
        .each do |post|
        post.write(dest_path)
      end
      write_index dest_path, publish_type
      copy_static_info dest_path
    end

    def write_index path, publish_type
      content = make_index_content path, publish_type

      template_path = File.join(File.dirname(__FILE__), *%w[.. layout index.html])
      stylesheet_path = File.join(File.dirname(__FILE__), *%w[.. css index.css])

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

    def make_index_content path, publish_type
      content = "<ul>"

      posts2proc = @posts
      if publish_type == :publish
        posts2proc = posts2proc
                       .select {|p| p.is_draft? == false}
      end

      posts2proc
        .each do |post|
        if post.meta_info != nil
          title, published_at, ignore, msg = post.make_meta_info
        end

        content.concat("<li>
                       <span>#{published_at}</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#{post.url}\">#{title}</a></br>
                       </li>")
      end
      content.concat("</ul>")
    end

    def copy_static_info dest_path = "dest"
      # make css directory, and copy every .css files in source to css directory
      FileUtils.mkdir_p(File.join(File.dirname(__FILE__), *%w[.. .. lib css]))
      FileUtils.cp_r(
        File.join(File.dirname(__FILE__), *%w[.. .. lib css/.]),
        File.join(dest_path, *%w[css])
      )

      # make font directory, and copy every font files
      FileUtils.mkdir_p(File.join(File.dirname(__FILE__), *%w[.. .. lib fonts]))
      FileUtils.cp_r(
        File.join(File.dirname(__FILE__), *%w[.. .. lib fonts/.]),
        File.join(dest_path, *%w[fonts])
      )
    end
  end
end
