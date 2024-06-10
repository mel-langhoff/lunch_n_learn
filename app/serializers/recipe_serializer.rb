class RecipeSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type { "recipe" }
  
  attributes :title, :url, :image, :country

end