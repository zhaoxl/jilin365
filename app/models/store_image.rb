class StoreImage < ActiveRecord::Base
  acts_as_list  scope: :store_id

  belongs_to  :user
  belongs_to  :store
  
  mount_uploader :image, StoreImageUploader
end