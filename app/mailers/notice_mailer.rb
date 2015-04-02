class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"

  def sendmail_confirm(email_from, email_to)
    @name = User.find_by(email:email_from).name
    p @name
    mail from: "#{email_from}",to: "#{email_to}", subject: "TextbookExcahnge"
  end
end