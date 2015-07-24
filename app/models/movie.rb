class Movie < ActiveRecord::Base

  
 
  has_many :reviews
  validates :title, presence: true
  validates :director, presence: true
  validates :description, presence: true
  # validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future
  mount_uploader :image, ImageUploader

 
  def review_average
      reviews.sum(:rating_out_of_ten)/reviews.size
  end

  def self.search(search)
    where("title LIKE ?", "%#{search}")
  end

  protected
  def release_date_is_in_the_future
    if release_date.present?
       errors.add(:release_date, "should be in past")if release_date >= Date.today
    end
  end
end

