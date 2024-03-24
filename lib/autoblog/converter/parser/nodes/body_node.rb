class BodyNode
  attr_reader :blocks, :consumed
  def initialize(blocks:, consumed:)
    @blocks = blocks
    @consumed  = consumed
  end

  def present?
    true
  end

  def null?
    false
  end
end
