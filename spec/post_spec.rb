require_relative '../lib/autoblog/post'

describe AutoBlog::Post do

  it "원본 글이 있는 곳에서 파일을 읽을 수 있다" do
    p = AutoBlog::Post.new('test.md')
    expect(p.content).to eq("HI!")
  end

  it "파일을 html로 변환할 수 있다" do
    p = AutoBlog::Post.new('test.md')
    expect(p.to_html(p.content)).to eq('<p>HI!</p>')
  end

  it "html로 변환된 파일을 저장할 수 있다" do
    p = AutoBlog::Post.new('test.md')
    converted = p.to_html(p.content)
    p.write('test.md', converted)
  end
end
