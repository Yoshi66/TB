class SubjectsController < ApplicationController
  def show
    @book = Book.where(course: params[:course].capitalize, number: params[:number])
  end
end
