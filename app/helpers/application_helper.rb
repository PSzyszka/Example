module ApplicationHelper
  def avatar_or_cover(movie)
    movie&.avatar.present? ? movie.avatar : movie.cover
  end

  def is_model_instance?(model, model_name)
    model.is_a?(model_name)
  end
end
