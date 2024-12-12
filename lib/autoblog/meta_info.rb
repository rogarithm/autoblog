module AutoBlog
  class MetaInfo
    END_SIGN = /^\*\*\*meta-info-ends\*\*\*/

    attr_reader :hash

    def initialize(file)
      @hash = read_meta_info(file)
    end

    def read_meta_info(file)
      lines = file.split("\n")
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

    def find_meta_info key
      @hash[key]
    end
  end
end
