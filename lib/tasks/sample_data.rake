namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
     #make_user(301, "Accounting")
     #make_user(301, "Accounting", "Biology")
     make_user(9780738213248,301, "Accounting")
     make_user2(9780738213248,9780123859150,201,"Accounting", "Biology")
     make_user3(9780738213248,9780123859150,9781456458881,201,"Accounting", "Biology","Music")
     make_user3(9780738213248,9780123859150,9781590305317,201,"Accounting", "Biology","Music")
   end
end

  def make_user(isbn,number,course)
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      number = number
      stock = Book.api_search(isbn)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      User.find_by(name: name).books.create!(course: course, number: number,isbn: isbn, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
  end

  def make_user2(isbn1,isbn2,number,course1,course2)
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      number = number
      stock = Book.api_search(isbn1)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      User.find_by(name: name).books.create!(course: course1, number: number,isbn: isbn1, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
      stock = Book.api_search(isbn2)
      User.find_by(name: name).books.create!(course: course2, number: number,isbn: isbn2, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
  end

  def make_user3(isbn1,isbn2,isbn3,number,course1,course2,course3)
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      number = number
      stock = Book.api_search(isbn1)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      User.find_by(name: name).books.create!(course: course1, number: number,isbn: isbn1, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
      stock = Book.api_search(isbn2)
      User.find_by(name: name).books.create!(course: course2, number: number,isbn: isbn2, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
      stock = Book.api_search(isbn3)
      User.find_by(name: name).books.create!(course: course3, number: number,isbn: isbn3, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
  end

