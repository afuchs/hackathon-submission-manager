exports.SubmissionStore = (client) ->
  this.add = (submission, callback) ->
    client.rpush 'submissions', submission, callback

  this.update = (submission, callback) ->
    # TODO: update submission

  this.get = (callback) ->
    client.lrange 'submissions', 0, -1, callback