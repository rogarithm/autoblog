module AutoBlog
  class Post
    attr_reader :content

    def initialize(file)
      @content = File.read(
        File.join(File.dirname(__FILE__), *%w[.. .. source], file)
      )
    end
  end
end
