class Payment < ApplicationRecord

  belongs_to :paying_user,
    class_name: 'User',
    foreign_key: :paying_user_id

  belongs_to :submitting_user,
    class_name: 'User',
    foreign_key: :submitting_user_id

end
