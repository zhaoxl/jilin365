class Store < ActiveRecord::Base
  belongs_to  :user
  has_many    :store_images, -> { order('position ASC') }

  
  def front_image
    self.store_images.first
  end
end
