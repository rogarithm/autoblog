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

    def make_meta_info(post)
      msg = ""
      required_keys = ["title", "published_at", "draft"]

      if required_keys.any? {|key| @hash[key].nil?}
        msg << "#{post.src_path}\n  required field not provided:"
        required_keys.each do |key|
          msg << " #{key}," if @hash[key].nil?
        end
        msg.sub!(/,$/, "")
        msg << "\n  trying to set default value for the fields..."
        msg << "\n  but you need to write in the markdown source file"
      end

      today = Date.today.to_s.gsub("-", "/")
      title, published_at, draft, msg = [
        @hash["title"] || post.nm,
        @hash["published_at"] || today,
        @hash["draft"],
        msg
      ]
    end
  end
end