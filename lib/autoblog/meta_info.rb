module AutoBlog
  class MetaInfo
    END_SIGN = /^\*\*\*meta-info-ends\*\*\*/

    def initialize(path, file)
      @path = path
      @file = file
    end

    def read_meta_info(path, file)
      file_content = File.read(File.join(path, file)).strip
      lines = file_content.split("\n")
      meta_info_ends = lines.find_index {|l| l =~ END_SIGN}
      if meta_info_ends.nil?
        meta_info = {"draft" => "yes"}
        return meta_info
      end

      meta_info = {}
      lines[0, meta_info_ends].each do |info|
        key = info.split(":")[0].strip
        value = info.split(":")[1].strip
        meta_info[key] = value ||= "EMPTY"
      end
      meta_info
    end
  end
end
