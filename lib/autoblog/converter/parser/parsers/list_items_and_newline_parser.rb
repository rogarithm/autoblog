require_relative "concerns/matches_plus"

class ListItemsAndNewlineParser < BaseParser
  include MatchesPlus

  def match(tokens)
    nodes, consumed = match_plus tokens, with: list_item_parser
    return Node.null if nodes.empty?
    return Node.null unless tokens.peek_at(consumed, 'NEWLINE')
    consumed += 1 # consume last newline

    ListNode.new(sentences: nodes, consumed: consumed)
  end
end

