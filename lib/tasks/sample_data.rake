namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
     #make_user(301, "Accounting")
     #make_user(301, "Accounting", "Biology")
     make_user(9780078023132,101, "Business")
     make_user2(9780078023132,9780321558237,101,101,"Business", "Biology")
     make_user2(9780078023132,9781285094069,101,101,"Business", "Chemistry")
     make_user3(9780078023132,9781285094069,9781422144114,101,205,303,"Business", "Business","Business")
     make_user2(9780495808756,9781133612100,201,101,"Philosophy","Philosophy")
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
      User.find_by(name: name).books.create!(course: course, number: number,isbn: isbn, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5], price: "30")
  end

  def make_user2(isbn1,isbn2,number1,number2,course1,course2)
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      stock = Book.api_search(isbn1)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      User.find_by(name: name).books.create!(course: course1, number: number1,isbn: isbn1, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5], price: "30")
      stock = Book.api_search(isbn2)
      User.find_by(name: name).books.create!(course: course2, number: number2,isbn: isbn2, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5], price: "40")
  end

  def make_user3(isbn1,isbn2,isbn3,number1,number2,number3,course1,course2,course3)
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
      User.find_by(name: name).books.create!(course: course1, number: number1,isbn: isbn1, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5], price: "30")
      stock = Book.api_search(isbn2)
      User.find_by(name: name).books.create!(course: course2, number: number2,isbn: isbn2, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5], price: "50")
      stock = Book.api_search(isbn3)
      User.find_by(name: name).books.create!(course: course3, number: number3,isbn: isbn3, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5], price: "70")
  end

