require_relative '../lib/autoblog'

describe AutoBlog do
  def clean_up(path)
    generated_files = Dir.entries(path).reject! {|entry| entry == "." or entry == ".."}
    generated_files.each do |f|
      FileUtils.rm("#{path}/#{f}")
    end
  end

  it "site 객체에 요청을 전달한다" do
    AutoBlog.process(
      File.join(File.dirname(__FILE__), *%w[source]),
      File.join(File.dirname(__FILE__), *%w[dest]),
    )
    clean_up(File.join(File.dirname(__FILE__), *%w[dest]))
  end
end
