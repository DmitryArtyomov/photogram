class TagService
  def initialize(tags)
    @incoming_tags = tags || []
    @tag_format = Tag
      .validators
      .find { |validator| validator.instance_of? ActiveModel::Validations::FormatValidator }
      .options[:with]
  end

  def tags
    incoming_tags.uniq.select { |tag| tag =~ tag_format }.map { |tag| Tag.find_or_create_by(text: tag) }
  end

  private

  attr_reader :incoming_tags, :tag_format
end
