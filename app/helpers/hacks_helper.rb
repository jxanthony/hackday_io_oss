module HacksHelper
  def is_current_contributor
    return false unless @hack.present? && current_user.present?
    @hack.contributions.detect {|c| c.user_id == current_user.id}
  end

  def is_creator
    return false unless @hack.present? && current_user.present?
    @hack.creator == current_user
  end
end
