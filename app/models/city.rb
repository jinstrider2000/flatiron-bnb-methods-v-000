class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  extend ArelTables

  def self.highest_ratio_res_to_listings
    self.all.sort_by {|city| city.listings.reservations.count/city.listings.count}[-1]
  end

  def self.most_res
    self.all.sort {|city1, city2| city1.listings.reservations.count <=> city2.listings.reservations.count}[-1]
  end

  def city_openings(range_begin, range_end)
    self.listings.joins(:reservations).where(reservations_arel[:checkout].lteq(range_begin).or(reservations_arel[:checkin].gteq(range_end)))
  end
end

