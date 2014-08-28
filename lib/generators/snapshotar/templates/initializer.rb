# Snapshotar Gem
# https://github.com/elchbenny/snapshotar
# Benjamin Müller
# 2014

Snapshotar.configure do |config|


  # Where to store your snapshots?
  # :s3   -> for amazon s3 service
  # :file -> local directory (default)
  config.storage_type = :file

  # Provide the models and their attributes to seralize in a nested array like this:
  #    [[ModelName1, :attribute1, :attribute2,...],[ModelName2, :attribute1]]
  #
  # or even better to read like this
  #    config.models << [Cinema, :id, :name, :coordinates, :cinema_more_images, :district_id]
  #    config.models << [District, :id, :name]
  config.models << []

end
