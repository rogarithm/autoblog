module AutoBlog
  class Post
    attr_reader :content

    def initialize(file)
      @content = File.read(
        File.join(File.dirname(__FILE__), *%w[.. .. source], file)
      ).strip
    end

    def to_html content
      "<p>#{content}</p>"
    end

    def write(file, converted)
      path = File.join(File.dirname(__FILE__), *%w[.. .. dest], file.sub(/\.md/, '.html'))
      File.open(path, 'w') do |f|
        f.write(converted)
      end
    end
  end
end
