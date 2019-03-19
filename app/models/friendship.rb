class Friendship < ApplicationRecord

  def friend_history
    final = []
    Tab.where(owed_by_user_id: user1_id, owed_to_user_id: user2_id).each do |tab|
      final << tab
      tab.payments.each do |payment|
        final << payment
      end
    end
    Tab.where(owed_by_user_id: user2_id, owed_to_user_id: user1_id).each do |tab|
      final << tab
      tab.payments.each do |payment|
        final << payment
      end
    end
    (final.sort_by {|item| item.created_at}).reverse
  end

end
