require_relative 'autoblog/site'

module AutoBlog
  def self.process(source_path, dest_path, include_draft="no")
    s = Site.new(source_path)
    s.process(dest_path, include_draft)
  end
end
