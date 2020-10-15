class Ingredient < ActiveHash::Base

  self.data = [
               {id: 0, name: '---'}, {id: 1, name: '肉'}, {id: 2, name: '野菜'}
              ]
end