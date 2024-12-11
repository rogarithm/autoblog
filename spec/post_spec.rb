require_relative '../lib/autoblog/post'
require 'helpers/spec_helper'

describe AutoBlog::Post, "post 객체는" do
  it "파일을 html로 변환할 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'simple.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    expect(p.to_html).to eq("<p>\n  HI!\n</p>\n")
  end

  it "html로 변환된 파일을 저장할 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'simple.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    dest_path = p.write(File.join(File.dirname(__FILE__), *%w[dest]))
    expect(File.exist? dest_path).to eq(true)
  end

  it "생성한 html의 상대 url 정보를 만들어낼 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'simple.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    url = p.make_url
    expect(url).to eq("./simple.html")
  end

  it "마크다운 내용만 따로 갖고 있는다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'has_meta_info.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    expect(p.source).not_to include("***meta-info-ends***")
  end

  it "인덱스 파일에 제공할 정보를 따로 저장한다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'has_meta_info.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    meta_info = p.read_meta_info(file_path, file_nm)
    meta_info.keys.each {|key|
      expect(meta_info[key]).not_to be_empty
    }
  end

  it "처음 만드는 블로그 글은 초안이다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'draft_post.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    meta_info = p.read_meta_info(file_path, file_nm)
    expect(meta_info['draft']).to eq('yes')
  end
end
