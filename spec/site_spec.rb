require_relative '../lib/autoblog/site'

describe AutoBlog::Site do
  def clean_up(path)
    generated_files = Dir.entries(path).reject! {|entry| entry == "." or entry == ".."}
    generated_files.each do |f|
      FileUtils.rm("#{path}/#{f}")
    end
  end

  context "path 내의 md 파일 모두 post 객체로 만든다" do
    it "path 내의 md 파일 목록을 가져온다" do
      s = AutoBlog::Site.new(File.join(File.dirname(__FILE__), *%w[source]))
      s.posts.each do |p|
        expect(p).to be_a AutoBlog::Post
      end
    end
  end

  it "만든 post 객체를 가지고 dest 디렉토리에 변환된 html 파일을 저장한다" do
      s = AutoBlog::Site.new(File.join(File.dirname(__FILE__), *%w[source]))
      s.process(File.join(File.dirname(__FILE__), *%w[dest]))
    clean_up(File.join(File.dirname(__FILE__), *%w[dest]))
  end
end
