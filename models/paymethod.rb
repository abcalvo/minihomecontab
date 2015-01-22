class Paymethod
	include DataMapper::Resource

	property :id, Serial
	property :name, String

	has n, :payments
end
