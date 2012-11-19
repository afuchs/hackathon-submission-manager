module.exports = (redisClient) ->
  class Submission
    constructor: (params={}) ->
      @name = params.name or undefined
      @description = params.description or undefined
      @hackers = params.hackers or []
      @platform = params.platform or undefined
      @apis = params.platform or []

    @insert: (submission) ->
      callback = (err, reply) ->
        if (err)
          console.log err
        
      redisClient.rpush 'submissions', JSON.stringify(submission), callback

    @get: (start, stop, callback) ->
      newCallback = (err, reply) ->        
        data = []
        if (err)
          console.log err
        if (reply)
          for sub in reply
            data.push JSON.parse sub  
        callback data

      redisClient.lrange 'submissions', start, stop, newCallback