# Middleman API [![Build Status](https://travis-ci.org/jordanandree/middleman-api.png?branch=master)](https://travis-ci.org/jordanandree/middleman-api)

Create JSON and XML endpoints generated from template frontmatter and content.

## Installation

Bundle with your Gemfile:

```ruby
gem "middleman-api"
```

Or install the standalone Gem:

```ruby
gem install "middleman-api"
```

## Usage

Activate the extension in your `config.rb`:

```ruby
activate :api
```

The extension will then look over each template in the sitemap and proxy frontmatter and content to JSON and XML endpoints.

**JSON**

```json
{
  "meta" {
    "title" : "Middleman",
    "foo" : "bar"
  },
  "path" : "/index.html",
  "content" : "..."  
}
```

**XML**

```xml
<hash>
  <meta>
    <title>Middleman</title>
    <foo>bar</foo>
  </meta>
  <path>/index.html</path>
  <content>
    ...
  </content>
</hash>
```

## Contributing
If there is any thing you'd like to contribute or fix, please:

* Fork the repo
* Make your changes
* Add Cucumber tests for any new functionality
* Verify all existing tests work properly
* Make a pull request

The Cucumber features for this project assume the gem is installed, so to make any changes you will need to build and install the gem locally with your changes.

## License
The middleman-api gem is Copyright 2013 Jordan Andree, distributed under the MIT License.