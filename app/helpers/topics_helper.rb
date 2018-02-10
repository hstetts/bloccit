module TopicsHelper
  def user_is_authorized_for_editing_topics?
    current_user && current_user.moderator? || current_user && current_user.admin?
  end

  def user_is_authorized_for_deleting_topics?
    current_user && current_user.admin?
  end

  def user_is_authorized_for_creating_topics?
    current_user && current_user.admin?
  end

end
