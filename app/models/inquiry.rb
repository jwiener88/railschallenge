class Inquiry < ActiveRecord::Base
	validates :checkin, :checkout, :presence => true
	validates :aptid, numericality: { only_integer: true }
	validate :apartment_id_must_exist
	validate :checkin_before_checkout

	def apartment_id_must_exist
		if !aptid.nil?
			if !Inventory.exists?(aptid)
				errors.add(:aptid, "Apartment must be in inventory")
			end
		end
	end

	def checkin_before_checkout
		if (!checkin.nil? && !checkout.nil?)
			if (checkin >= checkout )
				errors.add(:checkin, "Checkin must come before checkout")
			end
		end
	end
end
