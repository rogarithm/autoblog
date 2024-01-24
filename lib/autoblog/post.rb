require_relative 'markdown_parser'

module AutoBlog
  class Post
    attr_reader :url

    def initialize(path, file)
      @file_name = file.split(".").first
      @source = read_source(path, file)
      @url = make_url
      @parser = AutoBlog::MarkdownParser.new
    end

    def read_source(path, file)
      File.read(
        File.join(path, file)
      ).strip
    end

    def make_url
      ext = "html"
      "rogarithm.github.io/blog/".concat(@file_name, ".", ext)
    end

    def to_html
      @parser.convert_paragraph @source
    end

    def write(path)
      converted = self.to_html()
      dest_path = File.join(path, "#{@file_name}.html")
      File.open(dest_path, 'w') do |f|
        f.write(converted)
      end
      dest_path
    end
  end
end
