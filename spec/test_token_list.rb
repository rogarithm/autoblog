require 'minitest/autorun'
require 'pry'

class TestTokenList < Minitest::Test
  def setup
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

  def test_peek_or_success_when_matches_at_least_one
    token_list = @tokens.tokenize('_Foo_')
    assert_equal token_list.peek_or(%w(TEXT), %w(UNDERSCORE TEXT UNDERSCORE)), true
    assert_equal token_list.peek_or(%w(UNDERSCORE TEXT UNDERSCORE), %w(TEXT)), true
  end

  def test_type_sequence_captured_by_peek_should_be_in_order
    token_list = @tokens.tokenize('_Foo_')
    assert_equal token_list.peek('UNDERSCORE', 'TEXT', 'UNDERSCORE'), true
    assert_equal token_list.peek('TEXT'), false
  end

  def test_peek_at_can_specify_token_index_for_given_type
    token_list = @tokens.tokenize('_Foo_')
    assert_equal token_list.peek_at(1, 'TEXT'), true
    assert_equal token_list.peek_at(2, 'UNDERSCORE'), true
  end

  def test_grab_pick_some_tokens_when_not_exceed_token_count_in_tokenlist
    token_list = @tokens.tokenize('_Foo_')
    grabbed = token_list.grab!(1) 
    assert_equal grabbed[0].type, 'UNDERSCORE'
    assert_equal grabbed[0].value, '_'
  end

  def test_grab_raise_error_when_exceed_token_count_in_tokenlist
    token_list = @tokens.tokenize('_Foo_')
    assert_raises(RuntimeError) { token_list.grab!(5) } # _Foo_ has 5 tokens, the last of which is EOF.
  end

  def test_offset_returns_new_tokenlist_starts_from_nth_token
    token_list = @tokens.tokenize('_Foo_')
    n = 1
    assert_equal token_list.offset(n).tokens[0].value, 'Foo'
    assert_equal token_list.offset(n).tokens[1].value, '_'
    assert_equal token_list.offset(n).tokens[2].value, ''
  end
end
