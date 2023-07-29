class Playdate < ApplicationRecord
  belongs_to :coursegroup
  belongs_to :user
end
