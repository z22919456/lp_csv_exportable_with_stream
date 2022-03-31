# LpCSVExportableWithStream

This is an extension of [LaunchPadLab/lp_csv_exportable](https://github.com/LaunchPadLab/lp_csv_exportable), let you can export data with Live stream. 

When Export lager data, rails will fetch all data what you need and make generate scv data. Your download will start after scv file generated, that's This will make your project seems to broken.

But Live Stream will generate file while downloading. It's good for your user experience


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lp_csv_exportable_with_stream'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lp_csv_exportable_with_stream

## Usage

1. Follow the [LaunchPadLab/lp_csv_exportable](https://github.com/LaunchPadLab/lp_csv_exportable) basic usage. Like this

```ruby
class ExportUsers
  include LpCSVExportable::CanExportAsCSV

  column :first_name
  column :last_name
  column :email
  column 'User Role', model_methods: %i[membership name]
end

```

2. And add `include LpCSVExportable::WithStream` below `include LpCSVExportable::CanExportAsCSV`
```ruby
  include LpCSVExportable::CanExportAsCSV
  include LpCSVExportable::WithStream

  column :first_name
```

3. finally, replace `.to_csv`  with `.to_csv_lazy(self)`

```ruby
def index
    users = User.all

    respond_to do |format|
      format.csv do
        export = ExportUsers.new
        export.collection = users
        export.to_csv_lazy(self)
      end
    end
  end
```

## Filename Setting

You can setting your filename in Export Class, just add self.filename = "Your File Name"

```ruby
class ExportUsers
  include LpCSVExportable::CanExportAsCSV
  include LpCSVExportable::WithStream

  self.filename = "Your File Name" # This is base file name

```

Also, you can add prefix ro suffix for your file name when export. maybe exported date and so on.

```ruby
respond_to do |format|
  format.csv do
    export = ExportUsers.new
    export.collection = users
    export.filename_prefix = "#{Date.today.strftime("%Y-%m-%d %H:%M")}" # add prefix to your base filename
    export.filename_suffix = "version 2" # add suffix to your base filename
    export.to_csv_lazy(self)
  end
end

```


## Prevent N + 1 query

If your need to prevent n + 1 query, you can add `self.collection_includes = [:your, :relations]`, it will automatically includes relations of your collection

```ruby
class ExportUsers
  include LpCSVExportable::CanExportAsCSV
  include LpCSVExportable::WithStream

  self.filename = "Your File Name"
  self.collection_includes = [:address, :friends] # Equivalence with "collection.includes(:address, :friends)"
```
#### Note
What's N + 1 Query?
[Faster Rails: Eliminating N+1 queries](https://semaphoreci.com/blog/2017/08/09/faster-rails-eliminating-n-plus-one-queries.html)


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lp_csv_exportable_with_stream.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
