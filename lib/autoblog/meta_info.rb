require_relative 'logging'

module AutoBlog
  class MetaInfo
    include Logging

    END_SIGN = /^\*\*\*meta-info-ends\*\*\*/

    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    def self.from_file(file_content)
      self.new(self.read_meta_info(file_content))
    end

    def self.read_meta_info(file)
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
        meta_info[key] = value || nil
      end
      meta_info
    end

    def find_meta_info key
      @hash[key]
    end

    def make_meta_info(post_info = {})
      post_nm = post_info[:nm]
      src_path = post_info[:src_path]
      msg = ""
      required_keys = ["title", "published_at", "draft"]

      if required_keys.any? {|key| @hash[key].nil?}
        msg << "\nrequired field not provided:"
        required_keys.each do |key|
          msg << " #{key}," if @hash[key].nil?
        end
        msg.sub!(/,$/, "")
        msg << "\n  in #{src_path}"
        msg << "\n  set default value for the fields"
        msg << "\n  but you need to write values in the source file"

        logger.warn(msg)
      end

      today = Date.today.to_s.gsub("-", "/")
      title, published_at, draft = [
        @hash["title"] || post_nm,
        @hash["published_at"] || today,
        @hash["draft"]
      ]
    end
  end
end