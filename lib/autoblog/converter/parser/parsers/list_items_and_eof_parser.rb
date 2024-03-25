require_relative "concerns/matches_plus"

class ListItemsAndEofParser < BaseParser
  include MatchesPlus

  def match(tokens)
    nodes, consumed = match_plus tokens, with: list_item_parser

    return Node.null if nodes.empty?
    if tokens.peek_at(consumed, 'EOF')
      consumed += 1
    elsif tokens.peek_at(consumed, 'NEWLINE', 'EOF')
      consumed += 2
    else
      return Node.null
    end

    ListNode.new(sentences: nodes, consumed: consumed)
  end
end
