require_relative "base_parser"
require_relative "concerns/matches_first"

class ParagraphParser < BaseParser
  include MatchesFirst

  def match(tokens)
    match_first tokens, list_item_and_newline_parser, list_item_and_eof_parser, sentences_and_newline_parser, sentences_and_eof_parser
  end
end
