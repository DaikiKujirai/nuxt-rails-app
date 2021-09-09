
200.times do |i|
  Post.create!(
    user_id: 2,
    post_id: 0,
    content: "post content#{i}"
  )
end