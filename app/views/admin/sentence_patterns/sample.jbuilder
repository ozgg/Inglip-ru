json.data do
  json.id @builder.generator.seed
  json.type 'sentence_samples'
  json.attributes do
    json.text @builder.generate(@entity.pattern)
  end
end
