class Message < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  belongs_to :room
end
