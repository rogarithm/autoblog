require_relative '../lib/autoblog/site'
require 'helpers/spec_helper'

describe AutoBlog::Site do
  before(:each) do
      @site = AutoBlog::Site.new(File.join(File.dirname(__FILE__), *%w[source]))
  end

  it "path 내의 md 파일을 post 객체로 가지고 있다" do
    @site.posts.each do |p|
      expect(p).to be_a AutoBlog::Post
    end
  end

  it "html 파일을 만들어 dest 디렉토리에 저장한다" do
    dest_dir = File.join(File.dirname(__FILE__), *%w[dest])
    @site.process(dest_dir, :publish)
    clean_up(dest_dir)
  end

  it "변환한 html 파일의 url 정보를 가지고 있다" do
    @site.posts.each do |p|
      expect(p.url).to match(/\.\/[\w-]+\.html/) # \w = [a-zA-Z0-9_]
    end
  end

  it "각 post로 이동할 수 있는 탐색 페이지를 만들 수 있다" do
    dest_path = File.join(File.dirname(__FILE__), *%w[dest])
    index_page_path = File.join(File.dirname(__FILE__), *%w[dest], "index.html")

    @site.write_index dest_path, "no"

    expect(File).to exist(index_page_path)
  end

  it "인덱스 페이지 관련 정보를 post 객체로부터 가져올 수 있다" do
    meta_info = @site.posts.select {|p|
      p.url == "./has_meta_info.html"
    }[0].make_meta_info

    expect(meta_info).to eq(
      {
        "title" => "xxx",
        "published_at" => "2024/07/19",
        "draft" => "no"
      }
    )
  end

  it "인덱스 페이지 관련 정보 중 필수값이 없는 경우를 처리할 수 있다" do
    meta_info = @site.posts.select {|p|
      p.url == "./draft_post.html"
    }[0].make_meta_info

    expect(meta_info).to eq(
      {
        "title" => "draft_post",
        "published_at" => Date.today.to_s.gsub("-", "/"),
        "draft" => "yes"
      }
    )
  end

  it "publish할 때는 초안 블로그 글을 제외할 수 있다" do
  end

  it "draft할 때는 초안 블로그 글을 포함할 수 있다" do
  end
end
