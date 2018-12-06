# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(user_name: 'chauncyf', email: 'fanc@brandeis.edu', password: '123456789', email_confirmed: true, identity: 1)
User.create(user_name: 'irenezxr', email: 'xiangranzhao@brandeis.edu', password: '123456789', email_confirmed: true, identity: 1)
User.create(user_name: 'gggllm', email: 'limianguo@gmail.com', password: '123456789', email_confirmed: true, identity: 1)
User.create(user_name: 'visitor', email: 'visitor@brandeis.edu', password: '123456789', email_confirmed: true, identity: 2)

# To fix: timezone
10.times do
  Activity.create(activity_date: Faker::Time.forward(30),
                  place: Faker::Games::Overwatch.location,
                  content: Faker::MostInterestingManInTheWorld.quote,
                  theme_color: [:purple, :pink, :blue, :teal, :green, :orange, :brown, :grey].sample,
                  starter_id: 4, status: 2)
end
10.times do
  Activity.create(activity_date: Faker::Time.forward(30),
                  place: Faker::Hobbit.location,
                  content: Faker::Hobbit.quote,
                  theme_color: [:purple, :pink, :blue, :teal, :green, :orange, :brown, :grey].sample,
                  starter_id: 3, status: 2)
end
10.times do
  Activity.create(activity_date: Faker::Time.forward(30),
                  place: Faker::Games::Overwatch.location,
                  content: Faker::FamousLastWords.last_words,
                  theme_color: [:purple, :pink, :blue, :teal, :green, :orange, :brown, :grey].sample,
                  starter_id: 2, status: 2)
end
10.times do
  Activity.create(activity_date: Faker::Time.forward(30),
                  place: Faker::Games::Overwatch.location,
                  content: Faker::Games::Overwatch.quote,
                  theme_color: [:purple, :pink, :blue, :teal, :green, :orange, :brown, :grey].sample,
                  starter_id: 1, status: 2)
end

Tag.create(type_name: 'pullup', color: 'green')
Tag.create(type_name: 'push', color: 'orange')
Tag.create(type_name: 'squat', color: 'grey')
Tag.create(type_name: 'bicerp', color: 'red')
Tag.create(type_name: 'tricerp', color: 'green')
Tag.create(type_name: 'sprint', color: 'orange')
Tag.create(type_name: 'pushup', color: 'grey')
Tag.create(type_name: 'belly', color: 'purple')
Tag.create(type_name: 'pullup', color: 'yellow')
Tag.create(type_name: 'bumperss', color: 'pink')
Tag.create(type_name: 'chest press', color: 'green')


Follow.create(followee_id: 1, follower_id: 2)
Follow.create(followee_id: 1, follower_id: 3)
Follow.create(followee_id: 1, follower_id: 4)
Follow.create(followee_id: 1, follower_id: 5)
Follow.create(followee_id: 2, follower_id: 1)
Follow.create(followee_id: 3, follower_id: 1)
Follow.create(followee_id: 4, follower_id: 1)
Follow.create(followee_id: 5, follower_id: 1)
Follow.create(followee_id: 2, follower_id: 4)


Gym.create(name: "gosman", description: "this is gosman gym for brandeis univeristy open time : xxxxx")
