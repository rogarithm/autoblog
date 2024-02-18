require_relative '../lib/autoblog/converter/parser/parsers/parser_factory'
Dir.glob('./lib/autoblog/converter/**/*.rb').each do |file|
  require file
end
Dir.glob('./lib/autoblog/converter/generator/**/*.rb').each do |file|
  require file
end
require 'pry'

describe Generator do
  before(:each) do
    @tokenizer = Tokenizer.new
    @parser    = Parser.new
    @generator = Generator.new
  end

  def generate(markdown)
    tokens = @tokenizer.tokenize(markdown)
    ast    = @parser.parse(tokens)
    @generator.generate(ast)
  end

  it "generates_html" do
    expect(generate("__Foo__ and *text*.\n\nAnother para.")).to eq "<p><strong>Foo</strong> and <em>text</em>.</p><p>Another para.</p>"
  end
end
