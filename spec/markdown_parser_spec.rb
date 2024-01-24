require_relative '../lib/autoblog/markdown_parser'

describe AutoBlog::MarkdownParser do
  before(:each) do
      @m = AutoBlog::MarkdownParser.new
  end

  context "convert bold" do
    it "one case" do
      expect(@m.convert_bold '**a**').to eq('<strong>a</strong>')
    end

    it "has white space" do
      expect(@m.convert_bold '**a b**').to eq('<strong>a b</strong>')
    end

    it "two case" do
      expect(@m.convert_bold '**a b** **c**').to eq('<strong>a b</strong> <strong>c</strong>')
    end
  end
end
