class SubjectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @books = Book.where(course: params[:course].capitalize, number: params[:number]).all
  end


  def mail_send
    logger.debug '//////////////////////////////'
    logger.debug params
    logger.debug '//////////////////////////////'
    @mail = NoticeMailer.sendmail_confirm(params[:email_from], params[:email_to]).deliver
    redirect_to books_path
  end

end
