class StoreCategory < ActiveRecord::Base
  acts_as_list
  
  has_many  :stores, -> { order('position ASC') }
  
    
  def can_delete?
    !self.stores.exists?
  end
end
