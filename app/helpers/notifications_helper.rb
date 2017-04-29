module NotificationsHelper
  def notification_path_for(notification)
    if notification.notifiable_type == 'User'
      profile_path(notification.actor.profile)
    else
      '#'
    end
  end
end
