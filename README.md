[![Gem Version](https://badge.fury.io/rb/email_collector.png)](http://badge.fury.io/rb/email_collector)
# Email Collector

Helper utility for getting a number of email addresses based on a search request to Google. You may think of it as a search engine for emails.

## Installation

Install the gem using the following command:

```sh
$ gem install email_collector
```

## Usage

To collect a number of emails email_collector sends a specified request to Google and parses response pages. You can specify domain of a specific email provider (e.g. gmail.com, outlook.com) to improve matching. Of course, you should be connected to Internet to be able to send queries to Google.

For example, to get a number of developer emails, you can run

```ruby
emails = EmailCollector.collect('site:github.com', 'gmail.com')
```

or

```sh
$ irb
require 'email_collector'
EmailCollector.set_keywords([''])
emails = EmailCollector.collect('site:moikrug.ru', 'yandex.ru')
=> ["events@yandex.ru", "music@yandex.ru", "company@yandex.ru", "api@yandex.ru", "bar@yandex.ru", "market@yandex.ru", "m.market@yandex.ru", "weather@yandex.ru", "http@yandex.ru", "video@yandex.ru", "rabota@yandex.ru", "realty@yandex.ru", "www.Alik_Krasavchik@yandex.ru", "fotki@yandex.ru", "auto@yandex.ru", "news@yandex.ru", "m.video@yandex.ru", "mail@yandex.ru", "tv@yandex.ru", "m@yandex.ru", "m.weather@yandex.ru", "m.adresa@yandex.ru", "KornetovaAnna@yandex.ru", "tech@yandex.ru", "academy@yandex.ru", "startups@yandex.ru", "research@yandex.ru", "karagelena@yandex.ru", "rasp@yandex.ru", "expert@yandex.ru", "KarevAleksandr2@yandex.ru", "switchdetect@yandex.ru", "hockey2010@yandex.ru", "https@yandex.ru", "internet@yandex.ru", "alltests@yandex.ru", "toster@yandex.ru", "rk@yandex.ru", "love@yandex.ru", "Alex-11061967@yandex.ru", "sapbi@yandex.ru", "alexbaumgertner@yandex.ru", "mobile@yandex.ru", "opera@yandex.ru", "teraman@yandex.ru", "stas-fomin@yandex.ru", "kotilko@yandex.ru", "SPavlov@yandex.ru", "Agroliga2003@yandex.ru", "disk@yandex.ru", "pdd@yandex.ru", "peshkovaa@yandex.ru", "ks5269@yandex.ru", "Levech24-box@yandex.ru", "architecom@yandex.ru", "www@yandex.ru", "ikristina1@yandex.ru", "online@yandex.ru", "vasonik@yandex.ru", "gt@yandex.ru", "rostokina@yandex.ru"]

```


You can verify emails further by querring the correspondent mail server.
	
Please send questions to [alexei.fedotov@gmail.com](mailto:alexei.fedotov@gmail.com). Contribute via pull requests.

## Contributors

* Alexei Fedotov ([leshikus](https://github.com/leshikus))
