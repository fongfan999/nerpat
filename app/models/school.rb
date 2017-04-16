class School < ApplicationRecord
  has_many :profiles

  def to_s
    name.present? ? name : "Chưa cập nhật"
  end
end
