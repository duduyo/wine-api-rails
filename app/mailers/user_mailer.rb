class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_wines_email(email_address)
    mail(to: email_address, subject: 'Nouveautés dans notre catalogue de vins !')
  end
end
