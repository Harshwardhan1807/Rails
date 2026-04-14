class Movie < ApplicationRecord
  validates :title, presence: true
  validates :imdb_id, uniqueness: true, allow_nil: true
end
