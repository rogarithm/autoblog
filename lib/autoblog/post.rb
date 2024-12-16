require 'md2html'
require 'erb'
require_relative 'meta_info'

module AutoBlog
  class Post
    attr_reader :src_path, :nm, :source, :meta_info, :url

    def initialize(path, file)
      @src_path = File.join(path, file)
      @nm = file.split(".").first
      @source = read_source(path, file)
      @meta_info = read_meta_info(path, file)
      @url = make_url
    end

    def write(path)
      post_content = self.to_html
      post_page = wrap_with_template(post_content)
      dest_path = File.join(path, self.make_url)
      File.open(dest_path, 'w') do |f|
        f.write(post_page)
      end
      dest_path
    end

    def read_source(path, file)
      file_content = File.read(File.join(path, file)).strip
      lines = file_content.split("\n")
      src_starts = lines.find_index {|l| l =~ MetaInfo::END_SIGN}
      if src_starts != nil
        return lines[src_starts+1..-1].join("\n")
      else
        return lines.join("\n")
      end
    end

    def read_meta_info(path, file)
      file_content = File.read(File.join(path, file)).strip
      MetaInfo::from_file(file_content)
    end

    def make_meta_info
      @meta_info.make_meta_info(self)
    end

    def is_draft?
      @meta_info.find_meta_info("draft") == "yes"
    end

    def make_url(ext="html")
      "./#{@nm}.#{ext}"
    end

    def to_html
      #TODO
      # @source 안에 내용이 없을 경우, 이 상황을 에러 메시지로 알려주고
      # 해당 파일만 html로 변환하지 않도록 로직 바꾸기

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
