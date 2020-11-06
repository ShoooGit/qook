# すでにゲストユーザーが存在する場合は、ゲストユーザーとそれに紐づくデータを削除
if User.exists?(id: 1)
  user = User.find(1)
  user.destroy
end

# ゲストユーザーの作成
User.create(id: 1, nickname: "ゲスト", email: "guest@com", password: "guestpass1")

#肉じゃが
recipe = Recipe.new(user_id: 1, name: '肉じゃが', calorie: 400, time: 30)
recipe.image.attach(io: File.open('public/images/肉じゃが.jpg'), filename: '肉じゃが.jpg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 44, quantity: 150)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 160, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 212, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 320, quantity: 3)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 634, quantity: 200)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 594, quantity: 30)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 644, quantity: 5)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 544, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 584, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 574, quantity: 30)

# ぶりの照り焼き
recipe = Recipe.new(user_id: 1, name: 'ぶりの照り焼き', calorie: 400, time: 30)
recipe.image.attach(io: File.open('public/images/ぶりの照り焼き.jpg'), filename: 'ぶりの照り焼き.jpg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 657, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 594, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 574, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 584, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 544, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 644, quantity: 1)

# だし巻き卵
recipe = Recipe.new(user_id: 1, name: 'だし巻き卵', calorie: 100, time: 10)
recipe.image.attach(io: File.open('public/images/だし巻き卵.jpeg'), filename: 'だし巻き卵.jpeg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 660, quantity: 4)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 634, quantity: 90)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 644, quantity: 3)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 584, quantity: 10)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 574, quantity: 5)

# カレーライス
recipe = Recipe.new(user_id: 1, name: 'カレーライス', calorie: 800, time: 30)
recipe.image.attach(io: File.open('public/images/カレーライス.jpg'), filename: 'カレーライス.jpg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 54, quantity: 300)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 212, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 320, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 160, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 634, quantity: 700)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 629, quantity: 6)

# 焼きそば
recipe = Recipe.new(user_id: 1, name: '焼きそば', calorie: 600, time: 20)
recipe.image.attach(io: File.open('public/images/焼きそば.jpg'), filename: '焼きそば.jpg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 54, quantity: 200)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 160, quantity: 0.5)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 673, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 90, quantity: 0.25)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 554, quantity: 3)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 564, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 594, quantity: 30)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 684, quantity: 60)

# オムライス
recipe = Recipe.new(user_id: 1, name: 'オムライス', calorie: 750, time: 20)
recipe.image.attach(io: File.open('public/images/オムライス.jpg'), filename: 'オムライス.jpg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 24, quantity: 120)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 160, quantity: 0.25)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 260, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 694, quantity: 45)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 704, quantity: 5)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 554, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 564, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 660, quantity: 3)

# 親子丼
recipe = Recipe.new(user_id: 1, name: '親子丼', calorie: 650, time: 20)
recipe.image.attach(io: File.open('public/images/親子丼.jpeg'), filename: '親子丼.jpeg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 14, quantity: 100)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 160, quantity: 0.5)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 660, quantity: 2)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 634, quantity: 150)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 644, quantity: 3)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 544, quantity: 8)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 574, quantity: 30)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 584, quantity: 30)

# ハンバーグ
recipe = Recipe.new(user_id: 1, name: 'ハンバーグ', calorie: 400, time: 20)
recipe.image.attach(io: File.open('public/images/ハンバーグ.jpg'), filename: 'ハンバーグ.jpg')
recipe.save

RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 724, quantity: 300)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 160, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 734, quantity: 70)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 744, quantity: 30)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 660, quantity: 1)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 704, quantity: 30)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 694, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 594, quantity: 15)
RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: 574, quantity: 10)

