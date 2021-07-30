10.times do |n|
  name = "user#{n}"
  email = "#{name}@example.com"
  password = "password"
  user = User.find_or_initialize_by(email: email, is_active: true)

  if user.new_record?
    user.name = name
    user.password = "password"
    user.save!
  end
end

puts "users = #{User.count}"
