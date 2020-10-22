class RecipesService
  def self.search(search)
    if search != ""
      Recipe.where('user_id = ? and text LIKE(?)', current_user.id}, "%#{search}%")
    else
      Recipe.includes(:user).where(user_id: current_user.id)
    end
  end
end