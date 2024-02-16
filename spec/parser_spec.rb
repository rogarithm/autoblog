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

  it "test_simple" do
    body_node = parse("__Foo__ and *text*.\n\nAnother para.")
    expect(body_node.consumed).to eq 14
  end
end
