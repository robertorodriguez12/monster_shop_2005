require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)

      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end

    it 'top five items' do
      chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      #dog_shop items
      pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
      lizard_head = @dog_shop.items.create(name: "Chew Toy", description: "Yummy", price: 500, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
      barbie = @dog_shop.items.create(name: "She needs a friend", description: "Very Pink", price: 1000, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_1 = Order.create(name: 'Roberto', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_2 = Order.create(name: 'Brett', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_3 = Order.create(name: 'Nico', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)


      order.item_orders.create(item: tire, price: tire.price, quantity: 2)
      order.item_orders.create(item: pull_toy, price: pull_toy.price, quantity: 5)
      order.item_orders.create(item: dog_bone, price: tire.price, quantity: 7)
      order.item_orders.create(item: lizard_head, price: lizard_head.price, quantity: 8)
      order.item_orders.create(item: barbie, price: barbie.price, quantity: 9)
      order.item_orders.create(item: chain, price: chain.price, quantity: 6)

      # binding.pry

      expected = [barbie, lizard_head, dog_bone, chain, pull_toy]


      expect(Item.top_five_items).to eq(expected)

    end

    it 'bottom five items' do
      chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      #dog_shop items
      pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
      lizard_head = @dog_shop.items.create(name: "Chew Toy", description: "Yummy", price: 500, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
      barbie = @dog_shop.items.create(name: "She needs a friend", description: "Very Pink", price: 1000, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_1 = Order.create(name: 'Roberto', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_2 = Order.create(name: 'Brett', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_3 = Order.create(name: 'Nico', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)


      order.item_orders.create(item: tire, price: tire.price, quantity: 2)
      order.item_orders.create(item: pull_toy, price: pull_toy.price, quantity: 5)
      order.item_orders.create(item: dog_bone, price: tire.price, quantity: 7)
      order.item_orders.create(item: lizard_head, price: lizard_head.price, quantity: 8)
      order.item_orders.create(item: barbie, price: barbie.price, quantity: 9)
      order.item_orders.create(item: chain, price: chain.price, quantity: 6)

      # binding.pry

      expected = [tire, pull_toy, chain, dog_bone, lizard_head]


      expect(Item.five_least_popular_items).to eq(expected)

    end
  end
end
