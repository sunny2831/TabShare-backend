class Friendship < ApplicationRecord

  def tab_friendships
    relationships = []
    Tab.where(owed_by_user_id: user1_id, owed_to_user_id: user2_id).each do |tab|
      relationships << tab
      tab.payments.each do |payment|
        relationships << payment
      end
    end
    Tab.where(owed_by_user_id: user2_id, owed_to_user_id: user1_id).each do |tab|
      relationships << tab
      tab.payments.each do |payment|
        relationships << payment
      end
    end
    (relationships.sort_by {|item| item.created_at}).reverse
  end

end
