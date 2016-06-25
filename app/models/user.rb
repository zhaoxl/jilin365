class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to  :recommend_user, class_name: "User", foreign_key: :recommend_user_id

  
  has_one   :wallet
  has_one   :store
  has_many  :trade_infos
  has_many  :user_account_books
  has_many  :collects
  has_many  :user_cards
  has_many  :withdraws
  
  
  after_create :after_create_callback
  
  
  include AASM

  aasm column: :state do
    state :lock
    state :temp_lock
    state :create, :initial => true
    
    event :set_state_create do
      transitions :from => [:lock, :temp_lock], :to => :create
    end
     
    event :set_state_temp_lock do
      transitions :from => :create, :to => :temp_lock
    end
    
    event :set_state_lock do
      transitions :from => [:create, :temp_lock], :to => :lock
    end
  end
  
  
  def balance
    self.wallet.try(:balance).to_f
  end
  
  def income_balance
    self.wallet.try(:income_balance).to_f
  end
  
  def balance=(val)
    self_wallet = self.wallet||self.build_wallet
    self_wallet.balance = val.to_f
    self_wallet.save
  end
  
  def score
    self.wallet.try(:score).to_i
  end
  
  def score=(val)
    self_wallet = self.wallet||self.build_wallet(balance: 0, score: 0)
    self_wallet.score = val.to_f
    self_wallet.save
  end
  
  
  def after_create_callback
    
  end
  
  
  
end
