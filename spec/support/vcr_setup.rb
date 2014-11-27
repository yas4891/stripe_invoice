# spec/support/vcr_setup.rb
VCR.configure do |c|
	#the directory where your cassettes will be saved
	c.cassette_library_dir = 'spec/vcr'
	# your HTTP request service. You can also use fakeweb, webmock, and more
	c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
  allow_http_connections_when_no_cassette = true
end