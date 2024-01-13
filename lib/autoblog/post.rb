require_relative 'markdown_parser'

module AutoBlog
  class Post

    def initialize(file)
      @source = read_source file
      @parser = AutoBlog::MarkdownParser.new
    end

    def read_source file
      File.read(
        File.join(File.dirname(__FILE__), *%w[.. .. source], file)
      ).strip
    end

    def to_html
      @parser.convert_paragraph @source
    end

    def write(file, converted)
      path = File.join(File.dirname(__FILE__), *%w[.. .. dest], file.sub(/\.md/, '.html'))
      File.open(path, 'w') do |f|
        f.write(converted)
      end
    end
  end
end
