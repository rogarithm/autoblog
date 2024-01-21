module AutoBlog
  class Site
    attr_accessor :posts

    def initialize(path)
      @posts = []
      Dir["#{path}/*.md"].each do |full_path|
        md_file = full_path.split("/")[-1]
        @posts << Post.new(path, md_file)
      end
    end
  end
end
