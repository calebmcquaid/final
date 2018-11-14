class CompetitionUser < ApplicationRecord
  belongs_to :competition
  belongs_to :user
end
