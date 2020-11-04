# ゲストユーザーの作成
User.create(id: 1, nickname: "ゲスト", email: "guest@com", password: "guestpass1")

recipe = Recipe.new(
  user_id: 1,
  name: 'test',
  calorie: 1000,
  time: 60
)

recipe.image.attach(io: File.open('public/images/test.jpg'), filename: 'test.jpg')

recipe.save