get '/' do
	redirect '/payment'
end

# Payment API
get '/payment' do
	if params[:page].nil?
		@page = 0
	else
		@page = params[:page].to_i
	end

	if params[:count].nil?
		@count = 25
	else
		@count = params[:count].to_i
	end
	
	total_records = Payment.all.count 
	@total_pages = total_records / @count - 1

	@total_pages+=1 if total_records % @count > 0

	@payments = Payment.all(:offset => @page*@count, :limit => @count, :order => [ :date.desc, :id.desc ]).to_a

	@base_url = request.path_info
	@prev_page = "/payment?page=" + (@page - 1).to_s + "&amp;count=" + @count.to_s
	@next_page = "/payment?page=" + (@page + 1).to_s + "&amp;count=" + @count.to_s

	erb :payments
end

get /\/payment\/(company|paymethod|payer|passbook)\/(\d+)\/(company|paymethod|payer|passbook)\/(\d+)\/(company|paymethod|payer|passbook)\/(\d+)\/(company|paymethod|payer|passbook)\/(\d+)/ do
	first = params[:captures][0]+"_id"
	first_id = params[:captures][1]
	second = params[:captures][2]+"_id"
	second_id = params[:captures][3]
	third = params[:captures][4]+"_id"
	third_id = params[:captures][5]
	fourth = params[:captures][6]+"_id"
	fourth_id = params[:captures][7]

	if params[:page].nil?
		@page = 0
	else
		@page = params[:page].to_i
	end

	if params[:count].nil?
		@count = 25
	else
		@count = params[:count].to_i
	end
	
	total_records = Payment.all.count 
	@total_pages = total_records / @count - 1

	@total_pages+=1 if total_records % @count > 0

	@payments = Payment.all(first.to_sym => first_id, second.to_sym => second_id, third.to_sym => third_id, fourth.to_sym => fourth_id, :offset => @page*@count, :limit => @count, :order => [ :date.desc, :id.desc ]).to_a

	@base_url = request.path_info
	@prev_page = @base_url + "?page=" + (@page - 1).to_s + "&amp;count=" + @count.to_s
	@next_page = @base_url + "?page=" + (@page + 1).to_s + "&amp;count=" + @count.to_s

	erb :payments
	#{}"<p>"+first+" "+first_id+" "+second+" "+second_id+" "+third+" "+third_id+" "+fourth+" "+fourth_id+"</p>"
end

get /\/payment\/(company|paymethod|payer|passbook)\/(\d+)\/(company|paymethod|payer|passbook)\/(\d+)\/(company|paymethod|payer|passbook)\/(\d+)/ do
	first = params[:captures][0]+"_id"
	first_id = params[:captures][1]
	second = params[:captures][2]+"_id"
	second_id = params[:captures][3]
	third = params[:captures][4]+"_id"
	third_id = params[:captures][5]

	if params[:page].nil?
		@page = 0
	else
		@page = params[:page].to_i
	end

	if params[:count].nil?
		@count = 25
	else
		@count = params[:count].to_i
	end
	
	total_records = Payment.all.count 
	@total_pages = total_records / @count - 1

	@total_pages+=1 if total_records % @count > 0

	@payments = Payment.all(first.to_sym => first_id, second.to_sym => second_id, third.to_sym => third_id, :offset => @page*@count, :limit => @count, :order => [ :date.desc, :id.desc ]).to_a

	@base_url = request.path_info
	@prev_page = @base_url + "?page=" + (@page - 1).to_s + "&amp;count=" + @count.to_s
	@next_page = @base_url + "?page=" + (@page + 1).to_s + "&amp;count=" + @count.to_s

	erb :payments  
end

get /\/payment\/(company|paymethod|payer|passbook)\/(\d+)\/(company|paymethod|payer|passbook)\/(\d+)/ do
	first = params[:captures][0]+"_id"
	first_id = params[:captures][1]
	second = params[:captures][2]+"_id"
	second_id = params[:captures][3]

	if params[:page].nil?
		@page = 0
	else
		@page = params[:page].to_i
	end

	if params[:count].nil?
		@count = 25
	else
		@count = params[:count].to_i
	end
	
	total_records = Payment.all.count 
	@total_pages = total_records / @count - 1

	@total_pages+=1 if total_records % @count > 0

	@payments = Payment.all(first.to_sym => first_id, second.to_sym => second_id, :offset => @page*@count, :limit => @count, :order => [ :date.desc, :id.desc ]).to_a

	@base_url = request.path_info
	@prev_page = @base_url + "?page=" + (@page - 1).to_s + "&amp;count=" + @count.to_s
	@next_page = @base_url + "?page=" + (@page + 1).to_s + "&amp;count=" + @count.to_s

	erb :payments
end

get /\/payment\/(company|paymethod|payer|passbook)\/(\d+)/ do
	first = params[:captures][0]+"_id"
	first_id = params[:captures][1]

	if params[:page].nil?
		@page = 0
	else
		@page = params[:page].to_i
	end

	if params[:count].nil?
		@count = 25
	else
		@count = params[:count].to_i
	end
	
	total_records = Payment.all.count 
	@total_pages = total_records / @count - 1

	@total_pages+=1 if total_records % @count > 0

	@payments = Payment.all(first.to_sym => first_id, :offset => @page*@count, :limit => @count, :order => [ :date.desc, :id.desc ]).to_a

	@base_url = request.path_info
	@prev_page = @base_url + "?page=" + (@page - 1).to_s + "&amp;count=" + @count.to_s
	@next_page = @base_url + "?page=" + (@page + 1).to_s + "&amp;count=" + @count.to_s

	erb :payments
end

get '/payment/new' do
	@companies = Company.all(:order => [:name.asc])
	@paymethods = Paymethod.all(:order => [:name.asc])
	@payers = Payer.all(:order => [:name.asc])
	@passbooks = Passbook.all(:order => [:name.asc])

	erb :payment
end

post '/payment/new' do
	payment = Payment.new(:date => params[:date], :concept => params[:concept], :quantity => params[:quantity])

	if params[:number] != "null"
		payment.number = params[:number]
	end

	payment.company = Company.get(params[:company_id])
	payment.paymethod = Paymethod.get(params[:paymethod_id])
	payment.payer = Payer.get(params[:payer_id])
	if not params[:passbook_id].nil?
		payment.passbook = Passbook.get(params[:passbook_id])
	end

	if payment.save
		"{ \"status\": \"Ok\" }"
	else
		payment.errors.each do |e|
			puts e
		end
	end
end

post '/payment/edit/:id' do
	payment = Payment.get(params[:id])

	payment.date = params[:date]
	payment.concept = params[:concept]
	payment.quantity = params[:quantity]

	if params[:number] != "null"
		payment.number = params[:number]
	end

	payment.company = Company.get(params[:company_id])
	payment.paymethod = Paymethod.get(params[:paymethod_id])
	payment.payer = Payer.get(params[:payer_id])

	if not params[:passbook_id].nil?
		payment.passbook = Passbook.get(params[:passbook_id])
	end

	if payment.save
		"{ \"status\": \"Ok\" }"
	else
		payment.errors.each do |e|
			puts e
		end
	end
end

get '/payment/edit/:id' do
	@payment = Payment.get(params[:id])

	@companies = Company.all
	@paymethods = Paymethod.all
	@payers = Payer.all
	@passbooks = Passbook.all

	erb :payment
end

get '/payment/remove/:id' do
	payment = Payment.get(params[:id])

	payment.destroy

	redirect '/'
end

# Company API

get '/company' do
	@companies = Company.all

	erb :companies
end

post '/company/new' do
	company = Company.new(:name => params[:company])
	if company.save
		"{ \"status\": \"Ok\", \"id\": \"" + company.id.to_s + "\", \"company\": \"" + company.name + "\" }"
	else
		company.errors.each do |e|
			puts e
		end
	end
end

get '/company/remove/:id' do
	company = Company.get(params[:id])

	company.destroy

	redirect '/company'
end

post '/company/edit/:id' do
	company = Company.get(params[:id])

	company.name = params[:name]

	puts params[:name]

	if company.save
		"{ \"status\": \"Ok\", \"id\": \"" + company.id.to_s + "\", \"company\": \"" + company.name + "\" }"
	end
end

# Paymethod API

get '/paymethod' do
	@paymethods = Paymethod.all

	erb :paymethods
end

get '/paymethod/remove/:id' do
	paymethod = Paymethod.get(params[:id])

	paymethod.destroy

	redirect '/paymethod'
end

post '/paymethod/new' do
	paymethod = Paymethod.new(:name => params[:paymethod])
	if paymethod.save
		"{ \"status\": \"Ok\", \"id\": \"" + paymethod.id.to_s + "\", \"paymethod\": \"" + paymethod.name + "\" }"
	else
		paymethod.errors.each do |e|
			puts e
		end
	end
end

post '/paymethod/edit/:id' do
	paymethod = Paymethod.get(params[:id])

	paymethod.name = params[:paymethod]

	if paymethod.save
		"{ \"status\": \"Ok\", \"id\": \"" + paymethod.id.to_s + "\", \"paymethod\": \"" + paymethod.name + "\" }"
	end
end

# Passbook API

get '/passbook' do
	@passbooks = Passbook.all

	erb :passbooks
end

post '/passbook/new' do
	passbook = Passbook.new(:name => params[:passbook])
	if passbook.save
		"{ \"status\": \"Ok\", \"id\": \"" + passbook.id.to_s + "\", \"passbook\": \"" + passbook.name + "\" }"
	else
		passbook.errors.each do |e|
			puts e
		end
	end
end

get '/passbook/remove/:id' do
	passbook = Passbook.get(params[:id])

	passbook.destroy

	redirect '/passbook'
end

# Payer API

get '/payer' do
	@payers = Payer.all

	erb :payers
end

post '/payer/new' do
	payer = Payer.new(:name => params[:payer])
	if payer.save
		"{ \"status\": \"Ok\", \"id\": \"" + payer.id.to_s + "\", \"payer\": \"" + payer.name + "\" }"
	else
		payer.errors.each do |e|
			puts e
		end
	end
end

get '/payer/remove/:id' do
	payer = Payer.get(params[:id])

	payer.destroy

	redirect '/payer'
end

# ----------------------------

get '/update' do
	require_relative 'csvupdate'
	csv = CSVUpdate.new 'contab.csv'
	csv.parse
end

# ----------------------------
get '/name/:name' do
	@title = "Contab"
	@name = params[:name]
	erb :index
end