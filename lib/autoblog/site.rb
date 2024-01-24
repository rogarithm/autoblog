require_relative 'post'

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

    def prepare_index path
      content = ""
      @urls.keys.each do |key|
        content.concat("<a href=\"#{@urls[key]}\">#{key}</a>\n")
      end
      dest_path = File.join(path, "index.html")
      File.open(dest_path, 'w') do |f|
        f.write(content)
      end
      content
    end

    def process(path)
      @posts.each do |post|
        post.write(path)
      end
      prepare_index path
    end
  end
end
