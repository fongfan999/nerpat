class School < ApplicationRecord
  has_many :profiles

  def to_s
    name
  end
end
