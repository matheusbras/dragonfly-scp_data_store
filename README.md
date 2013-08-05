# Dragonfly::ScpDataStore

A dragonfly datastore adaptar for saving your files on remote servers using Net::SCP and Net::SSH.

## Installation

Drop this line to your application's Gemfile:

    gem 'dragonfly-scp_data_store'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly-scp_data_store

## Usage

On your dragonfly initializer:

```ruby
  app.configure do |c|
    c.datastore = Dragonfly::ScpDataStore::DataStore.new(
      host: ENV['CDN_SSH_HOST'], # This should be the host address of your remote server
      username: ENV['CDN_SSH_USERNAME'], # The username of your server
      password: ENV['CDN_SSH_PASSWORD'], # The password
      folder: ENV['CDN_FOLDER'], # The folder in which you're going to store your files
      base_url: ENV['CDN_BASE_URL'], # The url which you're going to retrieve your files from the server
    )
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
