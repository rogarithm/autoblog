require_relative "concerns/matches_first"

class ListItemAndNewlineParser < BaseParser
  include MatchesFirst

  def match(tokens)
    node = match_first tokens, list_item_parser
    return Node.null if node.null?
    return Node.null unless tokens.peek_at(node.consumed, 'NEWLINE')

    ParagraphNode.new(sentences: node, consumed: node.consumed + 2)
  end
end

