class Role < ActiveRecord::Base
	include ::ConstantExtend
	belongs_to  :admin
	has_and_belongs_to_many :permissions, :join_table => :roles_permissions
  
  validates :name, length: { in: 2..8 }, uniqueness: {scope: [:resource_type, :resource_id, :name]}, presence: true
      
  ROLE_SYSTEM = '系统管理员'

	validates :resource_type,
    :inclusion => { :in => Rolify.resource_types },
    :allow_nil => true

	scopify
end
