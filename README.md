# lita-slack-handler

**lita-slack-handler** is a handler for [Lita](https://github.com/jimmycuadra/lita) that allows you to use the robot with [Slack](https://slack.com/). This handler complements [lita-slack](https://github.com/kenjij/lita-slack) adapter gem.
**lita-slack-handler** sets up an HTTP route to accept messages from Slack:Outgoing WebHooks integrations, then feeds it into Lita.
This handler, otherwise, does nothing by itself; i.e., it does not produce any replies.

## Installation

Add **lita-slack-handler** to your Lita instance's Gemfile:

``` ruby
gem "lita-slack-handler"
```

But most likely, you'd be adding **lita-slack** gem as well:

``` ruby
gem "lita-slack"
gem "lita-slack-handler"
```

## Configuration

**First, you need to make sure your Slack team has [Outgoing WebHooks](https://my.slack.com/services/new/outgoing-webhook) integration setup with the correct Trigger Word(s) and URL:**

```
http://<Lita_server>:<Lita_port>/lita/slack-handler
```

Then, define the following attributes:

### Required attributes

* `webhook_token` (String) – Slack integration token.
* `team_domain` (String) – Slack team domain; subdomain of slack.com.

### Optional attributes
* `ignore_user_name` - Either a string with a single user name, or an array of strings. - Messages from these users will be ignored by lita-slack-handler. The _slackbot_ user is ignored by default in order to prevent chat loops and does not need to be listed here.

### Example lita_config.rb

``` ruby
Lita.configure do |config|
  config.robot.name = "Lita"
  # mention_name should match Slack integration Trigger Word
  config.robot.mention_name = "@lita"
  config.robot.alias = "lita"
  # Most likely you'll be using with the Slack adapter
  config.robot.adapter = :slack
  # Lita's HTTP port is used for Slack integration
  config.http.port = 8080
  # lita-slack-handler config
  config.handlers.slack_handler.webhook_token = "aN1NvAlIdDuMmYt0k3n"
  config.handlers.slack_handler.team_domain = "example"
  # Some more adapter and other config
  # .....
end
```

## Usage

None. **lita-slack-handler** just takes messages from Slack and feeds it into Lita.

## License

[MIT](http://opensource.org/licenses/MIT)
