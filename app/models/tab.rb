class Tab < ApplicationRecord

  has_many :payments

  belongs_to :owed_by_user,
    class_name: 'User',
    foreign_key: :owed_by_user_id

  belongs_to :owed_to_user,
    class_name: 'User',
    foreign_key: :owed_to_user_id

    def owed_by_user
      if self.balance > 0
        return User.find(self.owed_by_user_id)
      else
        return User.find(self.owed_to_user_id)
      end
    end

    def owed_to_user
      if self.balance > 0
        return User.find(self.owed_to_user_id)
      else
        return User.find(self.owed_by_user_id)
      end
    end

    def users
      return [self.owed_by_user, self.owed_to_user]
    end

    def other_user(current_user)
      (self.users.select {|user| user != current_user } )[0]
    end

    def balance
      #returns current balance always to the owed_by user
      #so if it returns a negative number, it means the only user is currently owing the balance
      return_balance = self.initial_amount_owed
      self.payments.each do |payment|
        if payment.paying_user_id === self.owed_by_user_id
          return_balance -= payment.payment_amount
        else
          return_balance += payment.payment_amount
        end
      end
      return return_balance
    end


end
