require_relative 'markdown_parser'
require 'erb'

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
      "./".concat(@file_name, ".", ext)
    end

    def to_html
      @parser.convert_paragraph @source
    end

    def wrap_with_template(
      converted,
      template_path=File.join(File.dirname(__FILE__), *%w[.. layout default.html]),
      style_path=File.join(File.dirname(__FILE__), *%w[.. css main.css])
    )
      b = binding
      b.local_variable_set(:converted, converted)
      b.local_variable_set(:style, style_path)
      template = ERB.new(File.read(template_path)).result(b)
    end

    def write(path)
      converted = self.to_html()
      template_wrapped = wrap_with_template(converted)
      dest_path = File.join(path, "#{@file_name}.html")
      File.open(dest_path, 'w') do |f|
        f.write(template_wrapped)
      end
      dest_path
    end
  end
end
