require_relative '../lib/autoblog/site'
require 'helpers/spec_helper'

describe AutoBlog::Site do
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

  it "각 post의 url 정보를 가지고 있다" do
      s = AutoBlog::Site.new(File.join(File.dirname(__FILE__), *%w[source]))
      s.urls.keys.each do |key|
        expect(s.urls[key]).to match(/\.\/[\w-]+\.html/)
      end
  end

  it "각 post로 이동할 수 있는 탐색 페이지를 만들어낼 수 있다" do
      s = AutoBlog::Site.new(File.join(File.dirname(__FILE__), *%w[source]))
      s.prepare_index File.join(File.dirname(__FILE__), *%w[dest])
      expect(File).to exist("#{File.join(File.dirname(__FILE__), *%w[dest], "index.html")}")
  end
end
