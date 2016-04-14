# Changelog

## v1.2.3

- Use custom session serialization for proper compatibility with mock users
  (#16)

## v1.2.2

- Improve serialization and devise compatibility

## v1.2.1

- Add support for multiple teams ([@bhuga])

## v1.2.0

- Add warden config to not intercept 401 status
- Support Rails 4.2 default of JSON marshalling
- Drop support for Rails 3.1

## v1.1.2

- Prevent loss of memberships in mocked user when marshaling

## v1.1.1

- Transform string to integer when stubbing team membership
- Place redirect helper in correct rack module

## v1.1.0

- Upgrade to octokit.rb version 2
- Require ruby 1.9 or higher

## v1.0.1

- Fully test on Rails 4
- Improve mock user membership stubbing
- Add testing instructions to README

## v1.0.0

- Add Devise compatibility

## v0.0.1

- Initial release

[@bhuga]: https://github.com/bhuga
