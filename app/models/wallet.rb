class Wallet < ActiveRecord::Base
  class InsufficientBalanceException < Exception
  end
  
  def self.waste(user, payment)
    wallet = Wallet.where(user_id: user).first
    raise InsufficientBalanceException unless wallet
    wallet.balance -= payment.amount
    raise InsufficientBalanceException if wallet.balance < 0
    wallet.save
  end
  
  def self.recharge(user, recharge)
    wallet = user.wallet||user.build_wallet
    wallet.balance += recharge.amount
    wallet.save
  end
  
  
  def self.income(user, amount)
    wallet = user.wallet||user.build_wallet
    wallet.income_balance +=  amount
    wallet.save
  end
  
  
end
