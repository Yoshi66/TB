class SubjectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @books = Book.where(course: params[:course].capitalize, number: params[:number]).all
  end
end
