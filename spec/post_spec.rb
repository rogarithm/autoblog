require_relative '../lib/autoblog/post'

describe AutoBlog::Post do

  it "마크다운 파일을 가져올 경로를 인자로 받는다" do
    p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
  end

  it "파일을 html로 변환할 수 있다" do
    p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
    expect(p.to_html()).to eq('<p>HI!</p>')
  end

  it "html로 변환된 파일을 저장할 수 있다" do
    p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
    p.write(File.join(File.dirname(__FILE__), *%w[dest]), 'test.md')
  end
end
