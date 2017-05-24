class Vote < ApplicationRecord
  enum flag: { up: true, down: false }

  belongs_to :user
  belongs_to :votable, polymorphic: true

  def self.point
    ## If the result have 2 records that were ordered by flag name,
    # so "down" is the first one and "up" is the last one
    ## If the result have only 1 record
    # Detect the flag and return positive or negative point
    vote_counts = select("flag, COUNT(flag) AS flag_count")
                  .group(:flag).order(:flag)

    if vote_counts.length == 2
      vote_counts[1].flag_count - vote_counts[0].flag_count
    elsif vote_counts.length == 1
      vote = vote_counts.first
      vote_point = vote.flag_count

      vote.up? ? vote_point : -(vote_point)
    else
      0 # Default point
    end
  end
end
