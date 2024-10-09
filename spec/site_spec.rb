require_relative '../lib/autoblog/site'
require 'helpers/spec_helper'

describe AutoBlog::Site do
  RSpec.configure do |config|
    config.filter_run_when_matching(focus: true)
    config.example_status_persistence_file_path = 'spec/pass_fail_history'
  end

  before(:each) do
      @site = AutoBlog::Site.new(File.join(File.dirname(__FILE__), *%w[source]))
  end

  context "path 내의 md 파일 모두 post 객체로 만든다" do
    it "path 내의 md 파일 목록을 가져온다" do
      @site.posts.each do |p|
        expect(p).to be_a AutoBlog::Post
      end
    end
  end

  it "dest 디렉토리에 post 객체로 html 파일을 저장한다" do
    dest_dir = File.join(File.dirname(__FILE__), *%w[dest])
    @site.process(dest_dir)
    clean_up(dest_dir)
  end

  it "각 post의 url 정보를 가지고 있다" do
    @site.posts.each do |post|
      expect(post.url).to match(/\.\/[\w-]+\.html/)
    end
  end

  it "각 post로 이동할 수 있는 탐색 페이지를 만들 수 있다" do
    @site.write_index File.join(File.dirname(__FILE__), *%w[dest])
    expect(File).to exist("#{File.join(File.dirname(__FILE__), *%w[dest], "index.html")}")
  end

  it "인덱스 페이지 관련 정보를 post 객체로부터 가져올 수 있다" do
    post = @site.posts.select {|p| p.url == "./has_meta_info.html"}.first
    expect(post.find_meta_info "title").to eq("xxx")
  end
end
