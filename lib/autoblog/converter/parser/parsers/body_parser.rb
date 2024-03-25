require_relative "base_parser"
require_relative "concerns/matches_star"

class BodyParser < BaseParser
  include MatchesStar

  def match(tokens)
    nodes, consumed, type = match_star tokens, with: block_parser
    return Node.null if nodes.empty?
    BodyNode.new(blocks: nodes, consumed: consumed)
  end
end
