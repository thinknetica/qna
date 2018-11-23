class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
end
