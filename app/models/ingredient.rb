class Ingredient < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' , unit: 'なし'}, { id: 1, name: '肉', unit: 'g' }, { id: 2, name: 'じゃがいも', unit: '個' }
  ]
end
