class Payment
	include DataMapper::Resource

	property :id, Serial
	property :date, Date
	property :concept, String
	property :quantity, Float
	property :number, Integer

	belongs_to :company
	belongs_to :paymethod
	belongs_to :payer, :required => false
	belongs_to :passbook, :required => false
end