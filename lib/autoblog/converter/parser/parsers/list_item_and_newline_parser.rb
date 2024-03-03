require_relative "concerns/matches_first"

class ListItemAndNewlineParser < BaseParser
  include MatchesFirst

  def match(tokens)
    node = match_first tokens, list_item_parser
    return Node.null if node.null?
    return Node.null unless tokens.peek_at(consumed, 'NEWLINE')
    consumed += 1 # consume newlines

    ParagraphNode.new(sentences: node, consumed: consumed)
  end
end

