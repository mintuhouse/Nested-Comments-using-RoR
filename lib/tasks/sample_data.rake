require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(:name => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  user = User.create!(:name => "Hasan Kumar Reddy",
                      :email => "mintuhouse@gmail.com",
                      :password => "123456",
                      :password_confirmation => "123456")
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_microposts
  (1..6).each do |iter|
    User.all(:limit => 20).each do |user|
      2.times do
        content = Faker::Lorem.sentence(5)
        user.microposts.create!(:content => content)
      end
    end
  end
  (1..3000).each do |i|
      content = Faker::Lorem.sentence(5)
      c = User.count
      User.first(:offset => rand(User.count)).microposts.create!(:content => content, 
                                :parent_id => Micropost.first(:offset => rand(Micropost.count)).id)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }  
  c = User.count
  (1..500).each do |i|
    followed = User.first(:offset => rand(c))
    follower = User.first(:offset => rand(c))
    if(followed!=follower)
      begin
        follower.follow!(followed)
      rescue
      end
    end
  end
end

