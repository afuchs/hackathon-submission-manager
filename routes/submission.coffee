exports.index = (req, res) ->
  req.app.models.Submission.get 0, -1, (data) ->
    console.log data
    console.log data.length
    res.render 'submissions', {title: "Submissions", submissions: data}

exports.add = (req, res) ->
  # TODO: Add to redis store and update clients
  hackers = []

  for hacker in req.body.hackers
    hackers.push new Hacker (
      name: hacker.name,
      email: hacker.email,
      role: hacker.role
    )

  submission = new Submission (
    name: req.body.name,
    description: req.body.description, 
    hackers: hackers,
    platform: req.body.platform, 
    apis: req.body.apis
  )

exports.delete = (req, res) ->
  # TODO: Delete from redis store and update clients