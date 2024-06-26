desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  User.destroy_all
  Delivery.destroy_all

  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save

    chars = [('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    random_string = ''

    10.times do
      delivery = Delivery.new
      delivery.user_id = user.id
      delivery.notes = Faker::Commerce.product_name
      delivery.tracking_number = rand(10000000000000000000000000)
      delivery.order_number = (0...8).map { chars[rand(chars.length)] }.join
      delivery.delivery_date = [Date.today - rand(365), Date.today + rand(72)].sample

      delivery.arrived = delivery.delivery_date <= Date.today

      delivery.save
    end

      # delivery = Delivery.new
      # delivery.user_id = user.id
      # delivery.notes = Faker::Commerce.product_name
      # delivery.tracking_number = 92001902849408300167903689
      # delivery.order_number = (0...8).map { chars[rand(chars.length)] }.join
      # delivery.arrived = true

      # delivery.save
  end
end
