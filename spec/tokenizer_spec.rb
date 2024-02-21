Dir.glob('./lib/autoblog/converter/tokenizer/**/*.rb').each do |file|
  require file
end
require 'pry'

describe Tokenizer do
  before(:each) do
    @tokenizer = Tokenizer.new
  end

  it "tokenize text" do
    tokens = @tokenizer.tokenize('Hi')
    expect(tokens.first.type).to eq 'TEXT'
    expect(tokens.first.value).to eq 'Hi'
  end

  it "tokenize text with underscores" do
    tokens = @tokenizer.tokenize('_Foo_')

    expect(tokens.first.type).to eq 'UNDERSCORE'
    expect(tokens.first.value).to eq '_'

    expect(tokens.second.type).to eq 'TEXT'
    expect(tokens.second.value).to eq 'Foo'

    expect(tokens.third.type).to eq 'UNDERSCORE'
    expect(tokens.third.value).to eq '_'
  end

  it "tokenize paragraph" do
    tokens = @tokenizer.tokenize("Hello, World!
This is a _quite_ **long** text for what we've been testing so far.

And this is another para.")
    #puts tokens
    expect(true).to eq true
  end

  it "tokenize text with dash" do
    tokens = @tokenizer.tokenize('- first item')

    expect(tokens.first.type).to eq 'DASH'
    expect(tokens.first.value).to eq '-'

    expect(tokens.second.type).to eq 'TEXT'
    expect(tokens.second.value).to eq ' first item'
  end

end
