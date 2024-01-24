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

  context "헤더" do
    it "마크다운 심볼과 내용 사이에 빈 칸이 없으면 변환되지 않는다" do
      expect(@m.convert_header3 '###hi there!').to eq('###hi there!')
    end
    it "마크다운 심볼과 내용은 하나 이상의 빈 칸으로 구분되어야 한다" do
      expect(@m.convert_header3 '### hi there!').to eq('<h3>hi there!</h3>')
      expect(@m.convert_header3 '###  hi there!').to eq('<h3>hi there!</h3>')
    end
  end

  context "단락" do
    it "빈 줄 없이 이어진 글을 하나의 단락으로 본다" do
      expect(@m.convert_paragraph "I really like using Markdown. I think I'll use it to format all of my documents from now on.").to eq("<p>I really like using Markdown. I think I'll use it to format all of my documents from now on.</p>")
    end
    it "하나의 빈 줄로 띄워지면 별개의 단락으로 본다" do
      expect(@m.convert_paragraph "I really like using Markdown.\nI think I'll use it to format all of my documents from now on.").to eq("<p>I really like using Markdown.</p>\n<p>I think I'll use it to format all of my documents from now on.</p>")
    end
    it "하나 이상의 빈 줄로 띄워지면 별개의 단락으로 본다" do
      expect(@m.convert_paragraph "I\n\nreally\nlikes\n\n\nyou!").to eq(
        "<p>I</p>\n<p>really</p>\n<p>likes</p>\n<p>you!</p>"
      )
    end
  end
end
