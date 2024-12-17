require_relative 'logging'

module AutoBlog
  class MetaInfo < Hash
    include Logging

    END_SIGN = /^\*\*\*meta-info-ends\*\*\*/

    def initialize(hash)
      super()
      self.merge!(hash)
    end

    def self.from_file(file_content)
      self.read_meta_info(file_content)
    end

    def self.read_meta_info(file)
      lines = file.split("\n")
      meta_info_ends = lines.find_index {|l| l =~ END_SIGN}
      if meta_info_ends.nil?
        meta_info = {}
        return self.new(meta_info).make_meta_info
      end

      meta_info = {}
      lines[0, meta_info_ends].each do |info|
        key = info.split(":")[0].strip
        value = info.split(":")[1].strip
        meta_info[key] = value || nil
      end

      self.new(meta_info).make_meta_info
    end

    def find_meta_info key
      self[key]
    end

    def make_meta_info(post_info = {})
      post_nm = post_info[:nm]
      src_path = post_info[:src_path]
      msg = ""
      required_keys = ["title", "published_at", "draft"]

      if required_keys.any? {|key| self[key].nil?}
        msg << "\nrequired field not provided:"
        required_keys.each do |key|
          msg << " #{key}," if self[key].nil?
        end
        msg.sub!(/,$/, "")
        msg << "\n  in #{src_path}"
        msg << "\n  set default value for the fields"
        msg << "\n  but you need to write values in the source file"

        logger.warn(msg)
      end

      today = Date.today.to_s.gsub("-", "/")
      self.merge({
        "title" => self["title"] || post_nm,
        "published_at" => self["published_at"] || today,
        "draft" => self["draft"] || "yes"
      })
    end
  end
end