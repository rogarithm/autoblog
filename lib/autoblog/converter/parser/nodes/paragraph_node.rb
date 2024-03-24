class ParagraphNode
  attr_reader :sentences, :consumed, :type
  def initialize(sentences:, consumed:)
    @sentences = sentences
    @consumed  = consumed
    @type = 'PARAGRAPH'
  end

  def present?
    true
  end

  def null?
    false
  end
end
