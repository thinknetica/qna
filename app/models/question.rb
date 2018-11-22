class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  has_many_attached :files

  validates :title, :body, presence: true
end
