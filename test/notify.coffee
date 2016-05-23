Helper = require 'hubot-test-helper'
expect = require('chai').expect
request = require 'request'

helper = new Helper('./../src/notify.coffee')

describe 'hubot-notify', ->
  @room = null

  beforeEach ->
    @room = helper.createRoom()
    @result = null

  afterEach ->
    @room.destroy()

  context "POST /notify/_hdbot", ->
    beforeEach (done) ->
      data = {message: "Ops is down!"}
      request.post {url: 'http://127.0.0.1:8080/notify/_hdbot', form: data}, (err, httpResponse, body) ->
        done()

    it 'notifies the whole #hdbot chan', ->
      expect(@room.messages).to.eql [
        ['hubot', 'Ops is down!']
      ]

  context "POST /notify/_hdbot/pchaigno", ->
    beforeEach (done) ->
      data = {message: "Gitlab is down!"}
      request.post {url: 'http://127.0.0.1:8080/notify/_hdbot/pchaigno', form: data}, (err, httpResponse, body) ->
        done()

    it 'notifies pchaigno on the #hdbot chan', ->
      expect(@room.messages).to.eql [
        ['hubot', 'pchaigno: Gitlab is down!']
      ]

  context "POST /notify/_hdbot", ->
    beforeEach (done) ->
      process.env.NOTIFY_SECRET = 'default'
      data = {message: "Bitbucket is down!", "secret": "default"}
      request.post {url: 'http://127.0.0.1:8080/notify/_hdbot', form: data}, (err, httpResponse, body) ->
        done()

    it 'use the correct secret', ->
      expect(@room.messages).to.eql [
        ['hubot', 'Bitbucket is down!']
      ]

  context "POST /notify/_hdbot", ->

    result = null

    beforeEach (done) ->
      process.env.NOTIFY_SECRET = 'default'
      data = {message: "Bitbucket is down!", "secret": "custom"}
      request.post {url: 'http://127.0.0.1:8080/notify/_hdbot', form: data}, (err, httpResponse, body) ->
        result = httpResponse
        done()

    it 'use the incorrect secret', ->
      expect(result.body).to.eql 'error: secret verification failed\n'
      expect(result.statusCode).to.eql 401
