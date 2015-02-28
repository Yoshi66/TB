namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

     make_accounting

     make_user(301, "Accounting")
     make_user(301, "Accounting", "Biology")
     make_user(301, "Accounting", "Biology", "Music")
   end
end


  def make_accounting
    5.times do
      make_user(101,"Accounting", "Biology","Music")
    end
  end

  def make_user(number,*courses)
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      number = number
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      courses.each do |a|
        User.find_by(name: name).books.create!(course: a, number: number)
      end
  end

