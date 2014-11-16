# Create an admin user
admin = User.new(
	name:     'Admin User',
	email:    'admin@example.com',
	password: 'helloworld',
	role:     'premium'
)
admin.skip_confirmation!
admin.save!

# Create a moderator
moderator = User.new(
	name:     'Moderator User',
	email:    'moderator@example.com', 
	password: 'helloworld',
	# role:     'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create a member
member = User.new(
	name:     'Member User',
	email:    'member@example.com',
	password: 'helloworld',
)
member.skip_confirmation!
member.save!


25.times do
	user = User.new(
		name:     Faker::Name.name,
		email:    Faker::Internet.email,
		password: Faker::Lorem.characters(10)
	)
	user.skip_confirmation!
	user.save!
end
users = User.all


50.times do
	Wiki.create!(
		user:     users.sample,
		title:    Faker::Lorem.sentence,
		outline:  Faker::Lorem.sentence,
		body:     Faker::Lorem.paragraph,
		public:   true
	)
end
50.times do
	Wiki.create!(
		user:     users.sample,
		title:    Faker::Lorem.sentence,
		outline:  Faker::Lorem.sentence,
		body:     Faker::Lorem.paragraph,
		public:   false
	)
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
