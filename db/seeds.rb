User.create!(name:  "kazukichi",
  email: "kazukichi@example.com",
  password:              "aaaaaa",
  password_confirmation: "aaaaaa",
  a_word: "マツダ",
  introduction: "宜しくお願いします",
  admin: true)

99.times do |n|
name  = Faker::Name.name
email = "kazukichi#{n+1}@example.com"
password = "aaaaaa"
a_word = "マツダ"
introduction = "よろよろ"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    a_word: a_word,
    introduction: introduction)
end
