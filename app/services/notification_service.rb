
class NotificationService

  def notify_user(notifiation_email)
    puts "Sending email to #{notifiation_email}"
    UserMailer.new_wines_email(notifiation_email).deliver_later
  end

end