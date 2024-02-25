require_relative "base_parser"
require_relative "concerns/matches_first"
#require_relative "concerns/matches_plus"
#require_relative "concerns/matches_one"

class ListItemParser < BaseParser
  def match(tokens)
    return Node.null
    #matches_one tokens.first
    # matches_plus tokens.except_first
    # matches_plus tokens.except_?
    # matches_one tokens.last
    #if ?
    # return Node.null
    #end
  end
end
