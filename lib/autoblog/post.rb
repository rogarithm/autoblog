require 'md2html'
require 'erb'

module AutoBlog
  INDEX_INFO_REGEX = /^\*\*\*index-content-ends\*\*\*/

  class Post
    attr_reader :url, :index_info

    def initialize(path, file)
      @file_name = file.split(".").first
      @source = read_source(path, file)
      @index_info = read_index_info(path, file)
      @url = make_url
    end

    def read_source(path, file)
      all_content = File.read(
        File.join(path, file)
      ).strip
      splitted = all_content.split("\n")
      src_starts = splitted.find_index {|l| l =~ INDEX_INFO_REGEX}
      if src_starts != nil
        return splitted[src_starts+1..-1].join("\n")
      else
        return splitted.join("\n")
      end
    end

    def read_index_info(path, file)
      all_content = File.read(
        File.join(path, file)
      ).strip
      splitted = all_content.split("\n")
      index_info_ends = splitted.find_index {|l| l =~ INDEX_INFO_REGEX}
      splitted[0, index_info_ends].join("\n") if index_info_ends != nil
    end

    def make_url
      ext = "html"
      "./".concat(@file_name, ".", ext)
    end

    def to_html
      Md2Html.make_html @source
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
