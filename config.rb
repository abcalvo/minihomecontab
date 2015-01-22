require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/database.db")

Dir['models/*.rb'].each { |model| require_relative model }

DataMapper.finalize
DataMapper.auto_upgrade!