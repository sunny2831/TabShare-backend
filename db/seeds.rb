# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'pry'

users = [
  {email: "latrice_royale@gmail.com", password: 'code', username: 'Latrice'},
  {email: "ginger_minj@gmail.com", password: 'code', username: 'Ginger'},
  {email: "naisha_lopez@gmail.com", password: 'code', username: 'Naisha'},
  {email: "manila_luzon@gmail.com", password: 'code', username: 'Manila'},
  {email: "trinity_taylor@gmail.com", password: 'code', username: 'Trinity'},
  {email: "sasha_velour@gmail.com", password: 'code', username: 'Sasha'},
  {email: "yuhua_hamasaki@gmail.com", password: 'code', username: 'Yuhua'},
  {email: "vanessa_vanjie@gmail.com", password: 'code', username: 'Vanessa'},
  {email: "shangela_laquifa@gmail.com", password: 'code', username: 'Shangela'},
  {email: "gia_gunn@gmail.com", password: 'code', username: 'Gia'},
  {email: "courtney_act@gmail.com", password: 'code', username: 'Courtney'},
  {email: "adore_delano@gmail.com", password: 'code', username: 'Adore'},
  {email: "darienne_lake@gmail.com", password: 'code', username: 'Darienne'},
  {email: "sharon_needles@gmail.com", password: 'code', username: 'Sharon'},
  {email: "bebe_zahara@gmail.com", password: 'code', username: 'Bebe'},
  {email: "bendela_creme@gmail.com", password: 'code', username: 'Bendela'},
  {email: "monique_heart@gmail.com", password: 'code', username: 'Monique'},
  {email: "monet_xchange@gmail.com", password: 'code', username: 'Monet'},
  {email: "alaska_thunder@gmail.com", password: 'code', username: 'Alaska'},
  {email: "roxxy_andrews@gmail.com", password: 'code', username: 'Roxxy'}
]

users.each do |user|
  # binding.pry
  User.create(email: user[:email], password: user[:password], username: user[:username])
end

descriptions = [
  "cinema tickets",
  "flights",
  "hotel stay",
  "lunch",
  "dinner",
  "brunch",
  "outing",
  "Wagamama bill",
  "Disneyland Trip",
  "groceries",
  "utilities",
  "household items",
  "electricity bill",
  "internet",
  "rent"
]

50.times do
 Tab.create(tab_total: rand(100...500), initial_amount_owed: rand(50...250), owed_by_user_id: rand(1...10), owed_to_user_id: rand(11...20), description: descriptions.sample)
end
#
#


Tab.all.each do |tab|
 Friendship.create(user1_id: tab.owed_to_user_id, user2_id: tab.owed_by_user_id) unless Friendship.where(user1_id: tab.owed_to_user_id, user2_id: tab.owed_by_user_id).length > 0
end
#
Tab.all.each do |tab|
  Payment.create(tab_id: tab.id, paying_user_id: tab.owed_by_user_id, submitting_user_id: tab.owed_to_user_id, payment_amount: rand(1...tab.initial_amount_owed))
end
