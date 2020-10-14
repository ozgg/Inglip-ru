json.data @collection do |entity|
  json.partial! 'lexeme', locals: { entity: entity }
end
