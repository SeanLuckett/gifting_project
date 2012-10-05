# Jeremy Ashkenas recommends using the following to be able to use Backbone's 
# "fetch" and "sync" methods without any extra transformations.
ActiveRecord::Base.include_root_in_json = false