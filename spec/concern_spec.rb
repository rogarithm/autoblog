Dir.glob('./lib/autoblog/converter/tokenizer/**/*.rb').each do |file|
  require file
end
require_relative '../lib/autoblog/converter/parser/parsers/parser_factory'
Dir.glob('./lib/autoblog/converter/**/*.rb').each do |file|
  require file
end
require 'pry'

describe MatchesStar do
  let(:ms) { Class.new { extend MatchesStar } }
  let(:mf) { Class.new { extend MatchesFirst } }

  before(:each) do
    @tokenizer = Tokenizer.new
    @sentence_parser = ParserFactory.build(:sentence_parser)
  end

  it "matches 0 or more" do
    tokens = @tokenizer.tokenize("matches 0 or more\n")
    nodes, consumed = ms.match_star(tokens, with: @sentence_parser)
    puts "NODES: #{nodes}, CONSUMED: #{consumed}"
  end

  it "matches only 1" do
    tokens = @tokenizer.tokenize("matches 0 or more\n")
    nodes, consumed = mf.match_first(tokens, @sentence_parser)
    puts "NODES: #{nodes}, CONSUMED: #{consumed}"
  end

  it "matches 1 or more" do
  end
end
