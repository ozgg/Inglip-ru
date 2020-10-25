json.id entity.id
json.type entity.lexeme_type.slug
json.attributes do
  json.call(entity, :body, :context, :wordforms_count)
end
