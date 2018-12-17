# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActivityType.create(name: 'CARDIO', type_index: 1, color: 'purple')
ActivityType.create(name: 'JOGGING', type_index: 2, color: 'blue')
ActivityType.create(name: 'LEG DAY!', type_index: 3, color: 'green')
ActivityType.create(name: 'LIFTING', type_index: 4, color: 'brown')
ActivityType.create(name: 'HIIT', type_index: 5, color: 'pink')
ActivityType.create(name: 'YOGA', type_index: 6, color: 'teal')
ActivityType.create(name: 'HIKING', type_index: 7, color: 'orange')
ActivityType.create(name: 'SWIMMING', type_index: 8, color: 'grey')

User.create(user_name: 'chauncyf', email: 'fanc@brandeis.edu', password: '123456789', email_confirmed: true, identity: 1)
User.create(user_name: 'irenezxr', email: 'xiangranzhao@brandeis.edu', password: '123456789', email_confirmed: true, identity: 1)
User.create(user_name: 'gggllm', email: 'limianguo@gmail.com', password: '123456789', email_confirmed: true, identity: 1)

User.create(user_name: Faker::Name.male_first_name, email: 'visitor1@brandeis.edu', password: '123456789', email_confirmed: true, identity: 2)
User.create(user_name: Faker::Name.male_first_name, email: 'visitor2@brandeis.edu', password: '123456789', email_confirmed: true, identity: 2)
User.create(user_name: Faker::Name.female_first_name, email: 'visitor3@brandeis.edu', password: '123456789', email_confirmed: true, identity: 2)
User.create(user_name: Faker::Name.female_first_name, email: 'visitor4@brandeis.edu', password: '123456789', email_confirmed: true, identity: 2)
User.create(user_name: Faker::Name.female_first_name, email: 'visitor5@brandeis.edu', password: '123456789', email_confirmed: true, identity: 2)



5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(31),
                             place: Faker::Games::Overwatch.location,
                             content: Faker::MostInterestingManInTheWorld.quote,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 4, status: 2)
  ActivityParticipant.create(user_id: 4,
                             activity_id: activity.id,
                             identity: 1)
  end
5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(31),
                             place: Faker::Games::Overwatch.location,
                             content: Faker::MostInterestingManInTheWorld.quote,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 5, status: 2)
  ActivityParticipant.create(user_id: 5,
                             activity_id: activity.id,
                             identity: 1)
end

5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(35),
                             place: Faker::Hobbit.location,
                             content: Faker::Hobbit.quote,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 6, status: 2)
  ActivityParticipant.create(user_id: 6,
                             activity_id: activity.id,
                             identity: 1)
  end

5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(33),
                             place: Faker::Games::Overwatch.location,
                             content: Faker::Games::Overwatch.quote,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 8, status: 2)
  ActivityParticipant.create(user_id: 8,
                             activity_id: activity.id,
                             identity: 1)
end

5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(35),
                             place: Faker::Hobbit.location,
                             content: Faker::Hobbit.quote,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 3, status: 2)
  ActivityParticipant.create(user_id: 3,
                             activity_id: activity.id,
                             identity: 1)
end
5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(32),
                             place: Faker::Games::Overwatch.location,
                             content: Faker::FamousLastWords.last_words,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 7, status: 2)
  ActivityParticipant.create(user_id: 7,
                             activity_id: activity.id,
                             identity: 1)
  end
5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(32),
                             place: Faker::Games::Overwatch.location,
                             content: Faker::FamousLastWords.last_words,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 2, status: 2)
  ActivityParticipant.create(user_id: 2,
                             activity_id: activity.id,
                             identity: 1)
end
5.times do
  activity = Activity.create(activity_date: Faker::Time.forward(30),
                             activity_end_time: Faker::Time.forward(33),
                             place: Faker::Games::Overwatch.location,
                             content: Faker::Games::Overwatch.quote,
                             activity_type_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
                             estimatedDuration: 30,
                             starter_id: 1, status: 2)
  ActivityParticipant.create(user_id: 1,
                             activity_id: activity.id,
                             identity: 1)
end

(0..40).each do |i|
  ActivityContent.create(activity_id: i,
                         sport_option: Faker::Esport.event,
                         quantity: "500 times")
end

(0..40).each do |i|
  ActivityContent.create(activity_id: i,
                         sport_option: Faker::Esport.event,
                         quantity: "20 km")
end


ActivityParticipant.create(user_id: 4,
                           activity_id: 5,
                           identity: 1)
ActivityParticipant.create(user_id: 5,
                           activity_id: 8,
                           identity: 1)
ActivityParticipant.create(user_id: 6,
                           activity_id: 7,
                           identity: 1)
ActivityParticipant.create(user_id: 7,
                           activity_id: 3,
                           identity: 1)
ActivityParticipant.create(user_id: 8,
                           activity_id: 2,
                           identity: 1)

# Tag.create(type_name: 'pullup', color: 'green')
# Tag.create(type_name: 'push', color: 'orange')
# Tag.create(type_name: 'squat', color: 'grey')
# Tag.create(type_name: 'bicerp', color: 'red')
# Tag.create(type_name: 'tricerp', color: 'green')
# Tag.create(type_name: 'sprint', color: 'orange')
# Tag.create(type_name: 'pushup', color: 'grey')
# Tag.create(type_name: 'belly', color: 'purple')
# Tag.create(type_name: 'pullup', color: 'yellow')
# Tag.create(type_name: 'bumperss', color: 'pink')
# Tag.create(type_name: 'chest press', color: 'green')


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


UserLocation.create(user_id: 4, latitude: 42.3714816, longitude: -71.258112)
UserLocation.create(user_id: 5, latitude: 42.37847, longitude: -71.255162)
UserLocation.create(user_id: 6, latitude: 42.37943, longitude: -71.258132)
UserLocation.create(user_id: 7, latitude: 42.37545, longitude: -71.253142)
UserLocation.create(user_id: 8, latitude: 42.37542, longitude: -71.253172)

