class Area < ActiveRecord::Base
  acts_as_nested_set
  acts_as_list scope: :parent_id
  
  has_one  :area_franchise
  
  def fullname
    (self.ancestors<<self).map(&:name).join(">")
  rescue
    nil
  end
end
