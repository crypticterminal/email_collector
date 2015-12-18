[![Gem Version](https://badge.fury.io/rb/email_collector.png)](http://badge.fury.io/rb/email_collector)
# Email Collector

Helper utility for getting a number of email addresses based on a search request to Google.

## Installation

Install the gem using the following command:

```sh
    $ gem install email_collector
```

## Usage

To collect a number of emails email_collector sends a specified request to Google and parses response pages. You can specify domain of a specific email provider (e.g. gmail.com, outlook.com) to improve matching.

For example, to get a number of developer emails, you can run

```ruby
emails = EmailCollector.collect('site:github.com', 'gmail.com')
```

You can verify emails further by querring the correspondent mail server.
	
Please send questions to [alexei.fedotov@gmail.com](mailto:alexei.fedotov@gmail.com).

## Contributors

* Alexei Fedotov ([https://github.com/leshikus]())

## Contributing yourself

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
