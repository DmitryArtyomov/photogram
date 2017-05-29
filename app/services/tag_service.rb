class TagService
  def initialize(tags)
    @incoming_tags = tags
  end

  def tags
    incoming_tags.map do |tag_text|
      unless tag = Tag.find_by(text: tag_text)
        tag = Tag.create(text: tag_text)
      end
      tag
    end
  end

  private

  attr_reader :incoming_tags
end
