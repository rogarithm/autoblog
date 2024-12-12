require_relative '../lib/autoblog/meta_info'
require 'helpers/spec_helper'

describe AutoBlog::MetaInfo, "meta info 객체는" do
  it "인덱스 파일에 제공할 정보를 따로 저장한다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'has_meta_info.md'
    file_content = File.read(File.join(file_path, file_nm)).strip

    meta_info = AutoBlog::MetaInfo.new(file_content).hash
    meta_info.keys.each {|key|
      expect(meta_info[key]).not_to be_empty
    }
  end

  it "처음 만드는 블로그 글은 초안이다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'draft_post.md'
    file_content = File.read(File.join(file_path, file_nm)).strip

    meta_info = AutoBlog::MetaInfo.new(file_content).hash
    expect(meta_info['draft']).to eq('yes')
  end
end
