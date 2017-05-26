class TagService
  def initialize(tags)
    @incoming_tags = tags
  end

  def tags
    result = []
    incoming_tags.each do |tag_text|
      unless tag = Tag.find_by(text: tag_text)
        tag = Tag.create(text: tag_text)
      end
      result.push(tag)
    end
    result
  end

  private

  attr_reader :incoming_tags
end
