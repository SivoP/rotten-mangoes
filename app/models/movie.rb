class Movie < ActiveRecord::Base

  
 
  has_many :reviews
  validates :title, presence: true
  validates :director, presence: true
  validates :description, presence: true
  # validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future
  mount_uploader :image, ImageUploader

  scope :query, ->(query) { where("title || director LIKE ?", "%#{query}%") }
  scope :short, ->  {where("runtime_in_minutes < 90")}
  scope :medium, -> {where("runtime_in_minutes BETWEEN 90 AND 120")}
  scope :long, ->   {where("runtime_in_minutes > 120")}
  
 
  def review_average
      reviews.sum(:rating_out_of_ten)/reviews.size
  end

  # def self.search(params)
  #   chain = []
  #   chain << :title if params[:title]
  #   chain << :director if params[:director]
  #   chain << :short if params[:duration] && params[:duration] == "short"
  #   chain << :medium if params[:duration] && params[:duration] == "medium"
  #   chain << :long if params[:duration] && params[:duration] == "long"

  #   chain.inject(Movie.all) {|object, method| object.send(method)}

  # end



  protected
  def release_date_is_in_the_future
    if release_date.present?
       errors.add(:release_date, "should be in past")if release_date >= Date.today
    end
  end


end
