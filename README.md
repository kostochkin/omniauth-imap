# omniauth-imap

An [OmniAuth][] strategy to allow you to authentication against IMAP.
Today it is suitable only for IMAP servers with STARTTLS security and PLAIN authentication.

## Installation

```
git clone https://github.com/kostochkin/omniauth-imap omniauth-imap
cd omniauth-imap
gem build omniauth-imap.gemspec
gem install omniauth-imap-0.0.1.gem
```

or add this line to Gemfile

```
gem 'omniauth-imap', git: 'https://github.com/kostochkin/omniauth-imap'
```


## Usage

### Gitlab config example

Add to config/gitlab.rb in the omniauth/providers section:

```
     - { name: "imap",
         label: "Login with IMAP",
         args: {
                 title: "Login as example.com user",
                 email_domain: "example.com",
                 host: "mail.example.com",
                 port: 143
               }
        }
```

## Author

Konstantin Gorshkov (k.n.gorshkov@gmail.com).

## License

MIT

[OmniAuth]: https://github.com/omniauth/omniauth

