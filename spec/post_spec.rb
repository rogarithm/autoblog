require_relative '../lib/autoblog/post'

describe AutoBlog::Post do
  before(:each) do
    @p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
  end

  it "파일을 html로 변환할 수 있다" do
    expect(@p.to_html()).to eq('<p>HI!</p>')
  end

  it "html로 변환된 파일을 저장할 수 있다" do
    dest_path = @p.write(File.join(File.dirname(__FILE__), *%w[dest]))
    expect(File.exist? dest_path).to eq(true)
  end

  it "url 정보를 만들어낼 수 있다" do
    url = @p.make_url
    expect(url).to eq("./test.html")
  end
end
