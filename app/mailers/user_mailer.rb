class UserMailer < ApplicationMailer
  def test_email(email)
    mail(to: email, subject: 'Test email from Rails app') do |format|
      format.text { render plain: "Đây là email test gửi từ Rails app" }
    end
  end
end
