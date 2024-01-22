require_relative 'markdown_parser'

module AutoBlog
  class Post

    def initialize(path, file)
      @file_name = file.split(".").first
      @source = read_source(path, file)
      @parser = AutoBlog::MarkdownParser.new
    end

    def read_source(path, file)
      File.read(
        File.join(path, file)
      ).strip
    end

    def to_html
      @parser.convert_paragraph @source
    end

    def write(path)
      converted = self.to_html()
      path = File.join(path, "#{@file_name}.html")
      File.open(path, 'w') do |f|
        f.write(converted)
      end
    end
  end
end
