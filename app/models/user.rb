class User < ApplicationRecord
  has_secure_password

  has_many :owed_by_tabs,
    class_name: 'Tab',
    foreign_key: :owed_by_user_id

  has_many :owed_to_tabs,
    class_name: 'Tab',
    foreign_key: :owed_by_user_id

  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)
    @user && @user.is_password?(password) ? @user : nil
  end

  def recent_activity
    final = []
    Tab.where(owed_by_user_id: id).each do |tab|
      final << tab
      tab.payments.each do |payment|
        final << payment
      end
    end
    Tab.where(owed_to_user_id: id).each do |tab|
      final << tab
      tab.payments.each do |payment|
        final << payment
      end
    end
    (final.sort_by {|item| item.created_at}).reverse
  end

  def friends
    friendships1 = Friendship.where(user1_id: self.id)
    friendships2 = Friendship.where(user2_id: self.id)
    final = []
    friendships1.map do |friendship|
      final << User.find(friendship.user2_id)
    end
    friendships2.map do |friendship|
      final << User.find(friendship.user1_id)
    end
    final
  end

  def balance_with(friend)
    tabs = Tab.where(owed_by_user_id: self.id, owed_to_user_id: friend.id) + Tab.where(owed_by_user_id: friend.id, owed_to_user_id: self.id)
    balance = 0
    tabs.each do |tab|
      if tab.owed_by_user_id == self.id
        balance -= tab.balance
      elsif tab.owed_to_user_id == self.id
        balance += tab.balance
      end
    end
    return balance
  end

  def highest_friend_balance
    balance = 1
    friends.each do |friend|
      self.balance_with(friend).abs > balance ? balance = self.balance_with(friend).abs : balance
    end
    balance
  end

  def friend_and_balance_array
    final = []
    self.friends.map do |friend|
      final << {id: friend.id, name: friend.name, balance: self.balance_with(friend)}
    end
    final
  end

  def tabs
    return self.owed_by_tabs + self.owed_to_tabs
  end

  def owed_tabs
    final = []
    self.tabs.each do |tab|
      if self.id == tab.owed_by_user_id && tab.balance > 0
        final << tab
      elsif self.id != tab.owed_by_user_id && tab.balance < 0
        final << tab
      end
    end
    final
  end

  def you_are_owed_tabs
    final = []
    #the signs < and > are opposite to method User#owed_tabs
    self.tabs.each do |tab|
      if self.id == tab.owed_by_user_id && tab.balance < 0
        final << tab
      elsif self.id != tab.owed_by_user_id && tab.balance > 0
        final << tab
      end
    end
    final
  end

  def you_owe
    total = 0
    self.tabs.each do |tab|
      if self.id == tab.owed_by_user_id && tab.balance > 0
        total += tab.balance
      elsif self.id != tab.owed_by_user_id && tab.balance < 0
        total += tab.balance
      end
    end
    total
  end

  def you_are_owed
    #
    total = 0
    #the signs < and > are opposite to the method User#you_owe
    self.tabs.each do |tab|
      if self.id == tab.owed_by_user_id && tab.balance < 0
        total += tab.balance
      elsif self.id != tab.owed_by_user_id && tab.balance > 0
        total += tab.balance
      end
    end
    total
  end

  def owed_tabs_info
    self.owed_tabs.map do |tab|
      {balance: tab.balance, name: tab.owed_to_user.name, id: tab.owed_to_user.id}
    end
  end

end
