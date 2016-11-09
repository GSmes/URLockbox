class LinkMailer < ApplicationMailer
  default :from => 'no-reply@urlockbox.com'

  def send_new_link_email(user, email, link)
    @user = user.email
    @email = email
    @link = link

    mail(
      :to => @email,
      :subject => "#{@user.email} sent a link!"
    )
  end
end
