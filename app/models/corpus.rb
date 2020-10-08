# frozen_string_literal: true

# Text corpus
#
# Attributes:
#   corpus_texts_count [Integer]
#   created_at [DateTime]
#   data [jsonb]
#   name [string]
#   updated_at [DateTime]
#   user_id [User], optional
#   uuid [uuid]
class Corpus < ApplicationRecord
  include Checkable
  include HasOwner
  include HasUuid

  NAME_LIMIT = 200

  belongs_to :user, optional: true
  has_many :corpus_texts, dependent: :delete_all

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user_id
  validates_length_of :name, maximum: NAME_LIMIT

  scope :ordered_by_name, -> { order('name asc') }
  scope :list_for_owner, ->(v) { owned_by(v).ordered_by_name }
  scope :list_for_administration, -> { order('id desc') }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  def self.entity_parameters
    %i[name]
  end
end
