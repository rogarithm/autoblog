require_relative '../lib/autoblog/converter/parser/parsers/parser_factory'
Dir.glob('./lib/autoblog/converter/**/*.rb').each do |file|
  require file
end
require 'pry'

describe Parser do
  before(:each) do
    @tokenizer = Tokenizer.new
    @parser = Parser.new
  end

  def parse(markdown)
    @parser.parse(@tokenizer.tokenize(markdown))
  end

  it "makes node from markdown content" do
    tokens = @tokenizer.tokenize("__Foo__ and *text*.\n\nAnother para.")
    body_node = @parser.parse(tokens)
    expect(body_node.consumed).to eq 14
  end

  it "parse text that has dash character" do
    tokens = @tokenizer.tokenize("- foo")
    nodes = @parser.parse(tokens)
    expect(nodes.consumed).to eq 3
  end

  it "list_item_parser parse one list item" do
    tokens = @tokenizer.tokenize("- foo\n")
    parser = ParserFactory.build(:list_item_parser)
    nodes = parser.match(tokens)
    expect(nodes.consumed).to eq 3
  end

  it "list_item_and_newline_parser parse one list item and newline" do
    tokens = @tokenizer.tokenize("- foo\n\n")
    parser = ParserFactory.build(:list_item_and_newline_parser)
    nodes = parser.match(tokens)
    expect(nodes.consumed).to eq 4
  end

  it "parse 1 list item and newline" do
    tokens = @tokenizer.tokenize("- foo\n")
    nodes = @parser.parse(tokens)
    expect(nodes.consumed).to eq 4
  end

  it "list_items_and_eof_parser parse list items of the same level" do
    tokens = @tokenizer.tokenize("- foo\n- bar\n- baz\n")
    parser = ParserFactory.build(:list_items_and_eof_parser)
    nodes = parser.match(tokens)
    expect(nodes.consumed).to eq 10 #(dash text newline) * 3 + eof
  end

  it "parse list items of the same level" do
    tokens = @tokenizer.tokenize("- foo\n- bar\n- baz\n")
    nodes = @parser.parse(tokens)
    expect(nodes.consumed).to eq 10 #(dash text newline) * 3 + eof
  end
end
