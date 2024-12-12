require_relative 'autoblog/site'

module AutoBlog
  def self.process(source_path, dest_path, publish_type=:publish)
    s = Site.new(source_path)
    s.process(dest_path, publish_type)
  end
end
