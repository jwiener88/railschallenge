class Inventory < ActiveRecord::Base
	def available? (inquiry)
		bookings = Booking.where(apt_id: inquiry.aptid)
		starting = inquiry.checkin
		ending = inquiry.checkout

		if (starting >= self.start && ending <= self.end) 
			bookings.each do | booking |
				if (booking.check_in < ending && booking.check_out > starting)
					return false ##This means there is a conflicting bookingg
				end
			end
			return true
		end
		return false
	end
end
