module HacksHelper
  def generate_activity_message(activity)
    case activity.action
    when "upvote"
      "#{activity.user.name} upvoted project #{activity.hack.title}."
    when "downvote"
      "#{activity.user.name} downvoted project #{activity.hack.title}."
    when "comment"
      "#{activity.user.name} commented on project #{activity.hack.title}."
    end
  end
end
