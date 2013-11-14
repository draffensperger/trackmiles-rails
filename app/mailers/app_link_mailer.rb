class AppLinkMailer < ActionMailer::Base 
  def android_app_link_email(email)
    mail to: email, subject: 'TrackMiles Android App Link'
  end
end
