require_relative "base_parser"
require_relative "concerns/matches_first"

class ListParser < BaseParser
  include MatchesFirst

  def match(tokens)
    match_first tokens, list_items_and_newline_parser, list_items_and_eof_parser, list_item_and_newline_parser, list_item_and_eof_parser
  end
end
