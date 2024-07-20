require_relative '../lib/autoblog/post'

describe AutoBlog::Post do
  RSpec.configure do |config|
    config.filter_run_when_matching(focus: true)
    config.example_status_persistence_file_path = 'spec/pass_fail_history'
  end

  it "파일을 html로 변환할 수 있다" do
    @p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
    expect(@p.to_html()).to eq(
'<p>
  HI!
</p>
')
  end

  it "html로 변환된 파일을 저장할 수 있다" do
    @p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
    dest_path = @p.write(File.join(File.dirname(__FILE__), *%w[dest]))
    expect(File.exist? dest_path).to eq(true)
  end

  it "url 정보를 만들어낼 수 있다" do
    @p = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test.md')
    url = @p.make_url
    expect(url).to eq("./test.html")
  end

  it "인덱스 파일에 제공할 정보를 제외하고 파싱한다" do
    @p_with_index_content = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test_index_content.md')
    expect(@p_with_index_content.to_html).to eq(
"<p>
  blah blah blah
</p>
")
  end

  it "인덱스 파일에 제공할 정보를 따로 빼낼 수 있다" do
    @p_with_index_content = AutoBlog::Post.new(File.join(File.dirname(__FILE__), *%w[source]), 'test_index_content.md')
    expect(@p_with_index_content.read_meta_info(File.join(File.dirname(__FILE__), *%w[source]), 'test_index_content.md')).to eq({'title' => 'xxx'})
  end
end
