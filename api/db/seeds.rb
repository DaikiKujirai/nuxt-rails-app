20.times do |i|
  Post.create!(
    user_id: 1,
    content: "post content#{i}"
  )
end