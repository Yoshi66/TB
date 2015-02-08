namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
     make_accounting
     make_biology
   end
end


  def make_accounting
    10.times do
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      course = 'Accounting'
      number = 101
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      User.find_by(name: name).books.create!(course: course, number: number)
    end
  end

  def make_biology
    5.times do
      name = Faker::Name.name
      email = Faker::Internet.email
      password = '11112222'
      password_confirmation = '11112222'
      course = 'Biology'
      number = 101
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password_confirmation)
      User.find_by(name: name).books.create!(course: course, number: number)
    end
  end