# Description:
#   Forwards notifications from a REST API to users
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Paul Chaignon <paul.chaignon@gmail.com>

module.exports = (robot) ->
  robot.router.post '/notify/:target', (req, res) ->
    if process.env.NOTIFY_SECRET? and req.body.secret isnt process.env.NOTIFY_SECRET
      res.status(401).send 'error: secret verification failed\n'
      return
    if req.params.target.match /^_/
      target = req.params.target.replace /^(_)+/, (match) ->
        Array(match.length + 1).join("#")
    else
      target = req.params.target
    robot.messageRoom "#{target}", req.body.message
    res.status(200).send 'delivered\n'

  robot.router.post '/notify/:room/:user', (req, res) ->
    if process.env.NOTIFY_SECRET? and req.body.secret isnt process.env.NOTIFY_SECRET
      res.status(401).send 'error: secret verification failed\n'
      return
    if req.params.room.match /^_/
      room = req.params.room.replace /^(_)+/, (match) ->
        Array(match.length + 1).join("#")
      robot.messageRoom "#{room}", "#{req.params.user}: #{req.body.message}"
      res.status(200).send 'delivered\n'
    else
      res.status(400).send 'error: you need to use underscores for #\n'
