module HacksHelper
  def all_tags
    ActsAsTaggableOn::Tag.all.map(&:name)
  end
end
