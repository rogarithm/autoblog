require 'md2html'
require 'erb'

module AutoBlog
  META_INFO_REGEX = /^\*\*\*meta-info-ends\*\*\*/

  class Post
    attr_reader :url, :meta_info

    def initialize(path, file)
      @file_name = file.split(".").first
      @source = read_source(path, file)
      @meta_info = read_meta_info(path, file)
      @url = make_url
    end

    def write(path)
      post_content = self.to_html()
      post_page = wrap_with_template(post_content)
      dest_path = File.join(path, "#{@file_name}.html")
      File.open(dest_path, 'w') do |f|
        f.write(post_page)
      end
      dest_path
    end

    def read_file(path, file)
      File.read(
        File.join(path, file)
      ).strip
    end

    def read_source(path, file)
      file_content = read_file(path, file)
      lines = file_content.split("\n")
      src_starts = lines.find_index {|l| l =~ META_INFO_REGEX}
      if src_starts != nil
        return lines[src_starts+1..-1].join("\n")
      else
        return lines.join("\n")
      end
    end

    def read_meta_info(path, file)
      file_content = read_file(path, file)
      lines = file_content.split("\n")
      meta_info_ends = lines.find_index {|l| l =~ META_INFO_REGEX}
      if meta_info_ends != nil
        meta_info = {}
        lines[0, meta_info_ends].each do |info|
          key = info.split(":")[0].strip
          value = info.split(":")[1].strip
          meta_info[key] = value ||= "EMPTY"
        end
        meta_info
      end
    end

    def find_meta_info key
      @meta_info[key]
    end

    def make_url
      ext = "html"
      "./#{@file_name}.#{ext}"
    end

    def to_html
      Md2Html.make_html @source
    end

    def wrap_with_template(
      converted,
      template_path=File.join(File.dirname(__FILE__), *%w[.. layout default.html]),
      stylesheet_path=File.join(File.dirname(__FILE__), *%w[.. css main.css])
    )

      b = binding
      b.local_variable_set(:converted, converted)
      b.local_variable_set(:style, stylesheet_path)
      template = ERB.new(File.read(template_path)).result(b)
    end
  end
end
