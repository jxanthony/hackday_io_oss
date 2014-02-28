module HacksHelper
  def is_current_contributor
    return false unless @hack.present? && current_user.present?
    @hack.contributors.include? current_user
  end
end
