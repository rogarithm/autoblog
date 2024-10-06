require_relative '../lib/autoblog/post'

describe AutoBlog::Post do
  RSpec.configure do |config|
    config.filter_run_when_matching(focus: true)
    config.example_status_persistence_file_path = 'spec/pass_fail_history'
  end

  it "파일을 html로 변환할 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'test.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    expect(p.to_html()).to eq(
'<p>
  HI!
</p>
')
  end

  it "html로 변환된 파일을 저장할 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'test.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    dest_path = p.write(File.join(File.dirname(__FILE__), *%w[dest]))
    expect(File.exist? dest_path).to eq(true)
  end

  it "url 정보를 만들어낼 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'test.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    url = p.make_url
    expect(url).to eq("./test.html")
  end

  it "인덱스 파일에 제공할 정보를 제외하고 파싱한다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'test_index_content.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    expect(p.to_html).not_to include("***meta-info-ends***")
  end

  it "인덱스 파일에 제공할 정보를 따로 빼낼 수 있다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'meta_info.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    expect(p.read_meta_info(file_path, file_nm)).to eq(
      {
        'title' => 'xxx',
        'draft' => 'no',
        'published_at' => '2024/07/19'
      }
    )
  end

  it "처음 만드는 블로그 글은 초안이다" do
    file_path = File.join(File.dirname(__FILE__), *%w[source])
    file_nm = 'draft_post.md'

    p = AutoBlog::Post.new(file_path, file_nm)
    expect(p.meta_info).to eq(
      {
        'draft' => 'yes'
      }
    )
  end
end
