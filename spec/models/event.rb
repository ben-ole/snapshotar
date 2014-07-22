# this is a sample model for testing purpose

class Event
   include Mongoid::Document

   field :name, type: String
   field :date, type: Date
end