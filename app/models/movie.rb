class Movie < ActiveRecord::Base
  validates :title, presence: true

  validates :director, presence: true

  validates :description, presence: true

  validates :poster_image_url, presence: true

  validates :release_date, presence: true

  validate :release_date_is_in_the_future
 
    def review_average
        reviews.sum(:rating_out_of_ten)/reviews.size
    end

  protected

  def release_date_is_in_the_future
    if release_date.present?
       errors.add(:release_date, "should be in future")if release_date < Date.today
    end
  end
end

