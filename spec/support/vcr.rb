require 'vcr'

VCR.config do |c|
  c.default_cassette_options = { :record => :new_episodes }
  c.cassette_library_dir = 'fixtures/cassette_libary'
  c.stub_with :webmock
end