# this is a sample model for testing purpose

class Band < Artist #:nodoc:
   include Mongoid::Document

   field :genre, type: String
end
