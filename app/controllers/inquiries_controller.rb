class InquiriesController < ApplicationController
	def index
		@inquiries = Inquiry.all
		@inquiry = Inquiry.new
	end

	def create
		@inquiry = Inquiry.new(inquiry_params)
		
		if Inventory.exists?(@inquiry.aptid) 
			apt = Inventory.find(@inquiry.aptid)
			@inquiry.availability = apt.available?(@inquiry)
		end

		if @inquiry.save
			redirect_to inquiries_path
		else
			@inquiries = Inquiry.all
			render "index"
		end
	end

	private
		def inquiry_params
			params.require(:inquiry).permit(:aptid, :checkin, :checkout)
		end
end
