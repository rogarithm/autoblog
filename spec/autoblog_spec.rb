require_relative '../lib/autoblog'
require_relative './helpers/spec_helper'

describe AutoBlog do
  it "site 객체에 요청을 전달한다" do
    AutoBlog.process(
      File.join(File.dirname(__FILE__), *%w[source]),
      File.join(File.dirname(__FILE__), *%w[dest]),
    )
    SpecHelper.clean_up(File.join(File.dirname(__FILE__), *%w[dest]))
  end
end
