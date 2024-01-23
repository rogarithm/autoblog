require_relative 'autoblog/site'

module AutoBlog
  def self.process(source_path, dest_path)
    s = Site.new(source_path)
    s.process(dest_path)
  end
end
