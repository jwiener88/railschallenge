require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "availability method" do
  	apartments = []
  	apartments[1] = inventories(:one)
  	apartments[2] = inventories(:two)
  	apartments[3] = inventories(:three)

  	inquiries_p = []
  	inquiries_p << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,18), :checkout=>Date.new(2015,4,19))
  	inquiries_p << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,18), :checkout=>Date.new(2015,4,20))
  	inquiries_p << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,16), :checkout=>Date.new(2015,4,19))
  	inquiries_p << Inquiry.new(:aptid => 2, :checkin=>Date.new(2015,2,14), :checkout=>Date.new(2015,2,19))
  	inquiries_p << Inquiry.new(:aptid => 2, :checkin=>Date.new(2015,4,18), :checkout=>Date.new(2015,5,14))
  	
  	## AVAILABILITY SHOULD RETURN FALSE FOR THESE ##
  	## Dates are not in the range
  	inquiries_f = []
  	## Completely before
  	inquiries_f << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,2,14), :checkout=>Date.new(2015,2,19))
  	## Completely after
  	inquiries_f << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,7,14), :checkout=>Date.new(2015,8,19))
  	## Overlapping the start
  	inquiries_f << Inquiry.new(:aptid => 2, :checkin=>Date.new(2015,2,10), :checkout=>Date.new(2015,2,15))
  	## Overlapping the end
   	inquiries_f << Inquiry.new(:aptid => 2, :checkin=>Date.new(2015,5,10), :checkout=>Date.new(2015,5,15))
    ## Overlapping the entirety
    inquiries_f << Inquiry.new(:aptid => 3, :checkin=>Date.new(2015,2,10), :checkout=>Date.new(2015,8,20))

    ## Already booked:
    ## Completely within another booking
  	inquiries_f << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,14), :checkout=>Date.new(2015,4,15))
  	## Overlapping the start of a booking
  	inquiries_f << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,18), :checkout=>Date.new(2015,4,22))
  	## Overlapping the end of a booking 
  	inquiries_f << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,22), :checkout=>Date.new(2015,4,28))
  	## Containing another booking entirely
  	inquiries_f << Inquiry.new(:aptid => 1, :checkin=>Date.new(2015,4,18), :checkout=>Date.new(2015,4,29))

  	inquiries_p.each do |inquiry|
  		assert apartments[inquiry.aptid].available?(inquiry)
  	end

  	inquiries_f.each_with_index do |inquiry, index|
  		assert(!apartments[inquiry.aptid].available?(inquiry) , "Assert failure on #{index}\n")
  	end
  end
end
