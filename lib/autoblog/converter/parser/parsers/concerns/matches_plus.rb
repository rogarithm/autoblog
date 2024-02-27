module MatchesPlus
  def match_plus(tokens, with:)
    matched_nodes = []
    consumed      = 0
    parser        = with

    while true
      node = parser.match(tokens.offset(consumed))
      break if node.null?
      matched_nodes += [node]
      consumed      += node.consumed
    end

    if consumed == 0
      Node.null
    else
      [matched_nodes, consumed]
    end
  end
end
