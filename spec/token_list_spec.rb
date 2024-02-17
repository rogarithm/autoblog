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

  it "peek_or_success_when_matches_at_least_one" do
    token_list = @tokens.tokenize('_Foo_')
    expect(token_list.peek_or(%w(TEXT), %w(UNDERSCORE TEXT UNDERSCORE))).to eq true
    expect(token_list.peek_or(%w(UNDERSCORE TEXT UNDERSCORE), %w(TEXT))).to eq true
  end

  it "type_sequence_captured_by_peek_should_be_in_order" do
    token_list = @tokens.tokenize('_Foo_')
    expect(token_list.peek('UNDERSCORE', 'TEXT', 'UNDERSCORE')).to eq true
    expect(token_list.peek('TEXT')).to eq false
  end

  it "peek_at_can_specify_token_index_for_given_type" do
    token_list = @tokens.tokenize('_Foo_')
    expect(token_list.peek_at(1, 'TEXT')).to eq true
    expect(token_list.peek_at(2, 'UNDERSCORE')).to eq true
  end

  it "grab_pick_some_tokens_when_not_exceed_token_count_in_tokenlist" do
    token_list = @tokens.tokenize('_Foo_')
    grabbed = token_list.grab!(1) 
    expect(grabbed[0].type).to eq 'UNDERSCORE'
    expect(grabbed[0].value).to eq '_'
  end

  it "grab_raise_error_when_exceed_token_count_in_tokenlist" do
    token_list = @tokens.tokenize('_Foo_')
    expect { token_list.grab!(5) }.to raise_error(RuntimeError) # _Foo_ has 5 tokens, the last of which is EOF.
  end

  it "offset_returns_new_tokenlist_starts_from_nth_token" do
    token_list = @tokens.tokenize('_Foo_')
    n = 1
    expect(token_list.offset(n).tokens[0].value).to eq 'Foo'
    expect(token_list.offset(n).tokens[1].value).to eq '_'
    expect(token_list.offset(n).tokens[2].value).to eq ''
  end
end
