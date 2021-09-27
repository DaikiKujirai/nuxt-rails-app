User.create!(
  name:         'ゲストユーザー'                ,
  email:        'guest@example.com'           ,
  uid:          'YuvPmK0RvARmEM5bed07KNuUtEl1',
  introduction: 'ゲストユーザーです。'           ,
  is_active:    true
)

# firebase
uids = [
  "RccFghZJbahvHaKqPXBQ1HaByKh1",
  "hFLCxZb70hg5Da43GeAG7M6zzso2",
  "ZzAwxfc3f7UuR1fsUgGipPU7gT83",
  "P0RFPgBMhMeyJY558sBsDvoyd3u1",
  "ZbI9dJMox2SRiLxX29oIPcTRqYv2",
  "RVESUwBMw5QGrZPecwaCzSmKFUg1",
  "UXBkWr2ujhUtLCkeEWwJDbM86Tr2",
  "Li9iCcD8egXw1KXlCkNAYyA7FU22",
  "QB8SfE3fkxUUHz0GZ4PnzbVfPHv2",
  "C1rKUluuHzOhdGVguwoqnMbkHMp1"
]

10.times do |i|
  User.create!(
    name:         Faker::JapaneseMedia::StudioGhibli.character,
    email:        "user#{i + 1}@example.com"                  ,
    uid:          uids[i]                                     ,
    introduction: Faker::JapaneseMedia::StudioGhibli.quote    ,
    is_active:    true
  )
end

10.times do |i|
  10.times do
    Post.create!(
      user_id: i + 1,
      post_id: 0,
      content: Faker::JapaneseMedia::StudioGhibli.quote
    )
  end
end