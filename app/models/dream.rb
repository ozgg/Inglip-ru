class Dream < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.letters
    %w(А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ы Э Ю Я)
  end

  def seed
    Digest::MD5.hexdigest(name).to_i(16)
  end

  def interpretation
    Speech.new(seed).passage
  end
end
