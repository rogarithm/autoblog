require_relative '../lib/autoblog/meta_info'
require 'helpers/spec_helper'

describe AutoBlog::MetaInfo, "meta info 객체는" do
  it "인덱스 파일에 제공할 정보를 따로 저장한다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'has_meta_info.md'

    meta_info = AutoBlog::MetaInfo.new(file_path, file_nm).read_meta_info(file_path, file_nm)
    meta_info.keys.each {|key|
      expect(meta_info[key]).not_to be_empty
    }
  end

  it "처음 만드는 블로그 글은 초안이다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'draft_post.md'

    meta_info = AutoBlog::MetaInfo.new(file_path, file_nm).read_meta_info(file_path, file_nm)
    expect(meta_info['draft']).to eq('yes')
  end
end
