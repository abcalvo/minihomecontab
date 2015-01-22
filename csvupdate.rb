require 'csv'

class CSVUpdate

	attr_accessor :file

	# Crear el objeto
	def initialize(file)
		self.file = file
	end

	def parse
		CSV.foreach(self.file, { :col_sep => ';' }) do |row|
			date = Date.strptime(row[0], '%d/%m/%y').strftime('%Y-%m-%d')
			company_name = row[1]
			concept = row[2]
			quantity = row[3].gsub(",", ".").gsub(/ €/, "")
			paymethod_name = row[4]
			payer_name = row[5]
			month = row[6]
			passbook_name = row[7]
			year = row[8]

			report = "Date: " + date.to_s + " Company: " + company_name.to_s + " Concept: " + concept.to_s + " Quantity: " + quantity.to_s +
				" Paymethod: " + paymethod_name.to_s + " Payer: " + payer_name.to_s + " Month: " + month.to_s + " Passbook: " + passbook_name.to_s +
				" Year: " + year.to_s

			puts report 

			payment = Payment.new(:date => date, :concept => concept, :quantity => quantity)

			payment.company = getCompany(company_name)
			payment.paymethod = getPaymethod(paymethod_name)
			if not payer_name.nil?
				payment.payer = getPayer(payer_name)
			end
			if not passbook_name.nil?
				payment.passbook = getPassbook(passbook_name)
			end
			
			if not payment.save
				puts "Error"
			end

		end
	end

	private def getCompany(company_name)
		company = Company.first(:name => company_name)

		if company.nil?
			company = Company.new(:name => company_name)
			if not company.save
				return nil
			end
		end

		return company
	end

	private def getPaymethod(paymethod_name)
		paymethod = Paymethod.first(:name => paymethod_name)

		if paymethod.nil?
			paymethod = Paymethod.new(:name => paymethod_name)
			if not paymethod.save
				return nil
			end
		end

		return paymethod
	end

	private def getPayer(payer_name)
		payer = Payer.first(:name => payer_name)

		if payer.nil?
			payer = Payer.new(:name => payer_name)
			if not payer.save
				return nil
			end
		end

		return payer
	end

	private def getPassbook(passbook_name)
		passbook = Passbook.first(:name => passbook_name)

		if passbook.nil?
			passbook = Passbook.new(:name => passbook_name)
			if not passbook.save
				return nil
			end
		end

		return passbook
	end

end