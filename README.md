# Inhouse Hound

forked from [thoughtbot/hound](https://github.com/thoughtbot/hound)

## deployment

```
bundle exec cap staging setup # first time only
bundle exec cap staging deploy
bundle exec cap staging resque:restart
```

## Resque Web Console

http://hostname/queue
