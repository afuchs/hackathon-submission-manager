# Test stuff
chai = require 'chai'
chai.should()
expect = chai.expect  # for use with undefined

# Bind Models and DB
redis = require 'redis'
redisClient = redis.createClient()
Submission = require('../models/submission')(redisClient)

# insert then pull and inspect
genRandNum = () ->
  Math.floor(Math.random() * 90000) + 10000

sub = new Submission(name: genRandNum(), description: "bla bla bla bla bla")

console.log "Inserting: "
console.log sub

Submission.insert(sub)

subs = Submission.get -1, -1, (data) ->
  console.log data
