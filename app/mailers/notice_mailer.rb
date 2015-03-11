class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm(email_from, email_to)
    @greeting = "Hi"
    mail from: "#{email_from}",to: "#{email_to}", subject: "TextbookExcahnge"
  end
end