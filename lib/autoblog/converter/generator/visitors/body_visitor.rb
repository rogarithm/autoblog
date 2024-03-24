require_relative "paragraph_visitor"

class BodyVisitor
  def visit(body_node)
    body_node.blocks.map do |block|
      paragraph_visitor.visit(block)
    end.join
  end

  private

  def paragraph_visitor
    @paragraph_visitor ||= ParagraphVisitor.new
  end
end
