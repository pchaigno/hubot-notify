# hubot-notify

[![Build Status](https://travis-ci.org/pchaigno/hubot-notify.svg?branch=master)](https://travis-ci.org/pchaigno/hubot-notify)
[![Coverage Status](https://coveralls.io/repos/github/pchaigno/hubot-notify/badge.svg?branch=master)](https://coveralls.io/github/pchaigno/hubot-notify?branch=master)

Exposes Hubot via a simple REST API to send messages to rooms and users.

## Installation

In your Hubot project directory, run:
```
npm install --save hubot-notify
```

Then add hubot-notify to your `external-scripts.json`:
```json
[
  "hubot-notify"
]
```


## Examples

To send a private message to john:
```bash
curl --data 'message=Hello%20john!' http://127.0.0.1:8080/notify/pchaigno
```

To post a message on `##project` (replace `#` with `_`):
```bash
curl --data 'message=Hi%20everyone!' http://127.0.0.1:8080/notify/__project
```

To send a message to john on `##project` (replace `#` with `_`):
```bash
curl --data 'message=Hi%20john!' http://127.0.0.1:8080/notify/__project/john
```


## License

This package is under [MIT license](LICENSE).
