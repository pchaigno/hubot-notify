Helper = require 'hubot-test-helper'
expect = require('chai').expect
request = require 'request'

helper = new Helper('./../src/notify.coffee')

describe 'hubot-notify', ->
  @room = null

  beforeEach ->
    @room = helper.createRoom()

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

  context "POST /notify/pchaigno", ->
    beforeEach (done) ->
      data = {message: "Oracle is down!"}
      request.post {url: 'http://127.0.0.1:8080/notify/pchaigno', form: data}, (err, httpResponse, body) ->
        done()

    it 'notifies pchaigno by private message', ->
      expect(@room.privateMessages).to.eql {
        'pchaigno': [
          ['hubot', 'Oracle is down!']
        ]
      }

  context "POST /notify/_hdbot/pchaigno", ->
    beforeEach (done) ->
      data = {message: "Gitlab is down!"}
      request.post {url: 'http://127.0.0.1:8080/notify/_hdbot/pchaigno', form: data}, (err, httpResponse, body) ->
        done()

    it 'notifies pchaigno on the #hdbot chan', ->
      expect(@room.messages).to.eql [
        ['hubot', 'pchaigno: Gitlab is down!']
      ]
