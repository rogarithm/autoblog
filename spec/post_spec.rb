require_relative '../lib/autoblog/post'

describe AutoBlog::Post do

  it "원본 글이 있는 곳에서 파일을 읽을 수 있다" do
    p = AutoBlog::Post.new('test.md')
    expect(p.content).to eq("HI!\n");
  end
end
