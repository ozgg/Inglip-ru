processed = {}
json.data @collection.flatten do |entity|
  next if processed.key? entity.id

  json.partial! 'lexeme', locals: { entity: entity }
  processed[entity.id] = true
end
