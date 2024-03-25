require_relative "concerns/matches_first"

class ListItemAndEofParser < BaseParser
  include MatchesFirst

  def match(tokens)
    node = match_first tokens, list_item_parser
    return Node.null if node.null?
    return Node.null unless tokens.peek_at(node.consumed, 'EOF')
    nodes, consumed = [node], node.consumed
    consumed += 1

    ListNode.new(sentences: nodes, consumed: consumed)
  end
end

