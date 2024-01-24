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

    def process(path)
      @posts.each do |post|
        post.write(path)
      end
    end
  end
end
