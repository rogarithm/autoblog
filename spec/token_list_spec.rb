Dir.glob('./lib/autoblog/converter/tokenizer/**/*.rb').each do |file|
  require file
end
require 'pry'

describe TokenList do
  before(:each) do
    @tokens = Tokenizer.new
    'Hi'
    '_Foo_'
    "Hello, World!
    This is a _quite_ **long** text for what we've been testing so far.

    And this is another para."
    #tokens = @tokenizer.tokenize('_Foo_')
#    tokens = @tokenizer.tokenize("Hello, World!
#This is a _quite_ **long** text for what we've been testing so far.
#
#And this is another para.")
  end

  it "peek_or() returns true if at least one matching token exists" do
    token_list = @tokens.tokenize('_Foo_')
    expect(token_list.peek_or(%w(TEXT), %w(UNDERSCORE TEXT UNDERSCORE))).to eq true
    expect(token_list.peek_or(%w(UNDERSCORE TEXT UNDERSCORE), %w(TEXT))).to eq true
  end

  it "should give tokens to peek() in same order with given token list" do
    token_list = @tokens.tokenize('_Foo_')
    expect(token_list.peek('UNDERSCORE', 'TEXT', 'UNDERSCORE')).to eq true
    expect(token_list.peek('TEXT')).to eq false
    expect(token_list.peek('UNDERSCORE', 'UNDERSCORE', 'TEXT')).to eq false
  end

  it "peek_at() needs token position to check" do
    token_list = @tokens.tokenize('_Foo_')
    expect(token_list.peek_at(1, 'TEXT')).to eq true
    expect(token_list.peek_at(2, 'UNDERSCORE')).to eq true
  end

  it "grab() picks tokens of smaller count than total token count" do
    token_list = @tokens.tokenize('_Foo_')
    grabbed = token_list.grab!(1) 
    expect(grabbed[0].type).to eq 'UNDERSCORE'
    expect(grabbed[0].value).to eq '_'
  end

  it "grab raise error when token count exceeds total token count" do
    token_list = @tokens.tokenize('_Foo_')
    expect { token_list.grab!(5) }.to raise_error(RuntimeError) # _Foo_ has 5 tokens, the last of which is EOF.
  end

  it "offset() returns new tokenlist starts from nth token" do
    token_list = @tokens.tokenize('_Foo_')
    n = 1
    expect(token_list.offset(n).tokens[0].value).to eq 'Foo'
    expect(token_list.offset(n).tokens[1].value).to eq '_'
    expect(token_list.offset(n).tokens[2].value).to eq ''
  end
end
