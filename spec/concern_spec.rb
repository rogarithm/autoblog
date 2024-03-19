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
  let(:mp) { Class.new { extend MatchesPlus } }

  before(:each) do
    @tokenizer = Tokenizer.new
    @sentence_parser = ParserFactory.build(:sentence_parser)
    @dash_parser = ParserFactory.build(:dash_parser)
    @text_parser = ParserFactory.build(:text_parser)
  end

  it "matchesStar matches 0 or more" do
    zero = @tokenizer.tokenize("")
    nodes, consumed = ms.match_star(zero, with: @sentence_parser)
    expect(consumed).to eq(0)

    one = @tokenizer.tokenize("matches 0 or more\n")
    nodes, consumed = ms.match_star(one, with: @sentence_parser)
    expect(consumed).to eq(1)

    more = @tokenizer.tokenize("- matches 0 or more\n")
    nodes, consumed = ms.match_star(more, with: @sentence_parser)
    expect(consumed).to eq(2)
  end

  it "matchesFirst matches only 1" do
    zero = @tokenizer.tokenize("\n")
    node = mf.match_first(zero, @dash_parser, @text_parser)
    expect(node).to eq(Node.null)

    one = @tokenizer.tokenize("ttt\n")
    node = mf.match_first(one, @dash_parser, @text_parser)
    expect(node.consumed).to eq(1)

    two = @tokenizer.tokenize("- ttt\n")
    node = mf.match_first(two, @dash_parser, @text_parser)
    expect(node.consumed).to eq(1)
  end

  it "matchesPlus matches 1 or more" do
    zero = @tokenizer.tokenize("")
    nodes, consumed  = mp.match_plus(zero, with: @sentence_parser)
    expect(nodes).to eq([])

    one = @tokenizer.tokenize("ttt")
    nodes, consumed  = mp.match_plus(one, with: @sentence_parser)
    expect(nodes.first.value).to eq("ttt")
    expect(consumed).to eq(1)
  end
end
