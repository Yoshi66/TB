class SubjectsController < ApplicationController
  def show
    @books = Book.where(course: params[:course].capitalize, number: params[:number]).all
  end
end
