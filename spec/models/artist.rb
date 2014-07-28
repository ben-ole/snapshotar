# this is a sample model for testing purpose
require 'carrierwave/mongoid'
require_relative './image_uploader'

class Artist #:nodoc:
   include Mongoid::Document

   mount_uploader :avatar, ImageUploader

   field :name, type: String
end
