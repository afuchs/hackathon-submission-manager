express = require('express')
routes = require('./routes')
submissionRoutes = require('./routes/submission')
http = require('http')
path = require('path')
#config = require('./config')
redis = require('redis')

#submission = require('./routes/submission')

app = express()

# Bind Models and DB
redisClient = redis.createClient()
app.models = {}
app.models.Submission = require('./models/submission')(redisClient)
app.models.Hacker = require('./models/hacker')

redisClient.on "error", (error) ->
    console.log "RedisError " + err

bindDb = (req, res, next) ->
  req.app = app
  next()

app.configure () ->
  app.set('port', process.env.PORT || 3000)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'ejs')
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(path.join(__dirname, 'public')))
  app.use(bindDb);

app.configure 'development', () ->
  app.use(express.errorHandler({dumpExceptions: true, showStack: true}))

app.configure 'production', () ->
  app.use(express.errorHandler())

# set up routes
app.get '/', routes.index
app.get '/submissions', submissionRoutes.index
#app.get '/submission/add', submission.add

server = http.createServer(app)

# socket.io setup
io = require('socket.io').listen(server)

io.sockets.on "connection", (socket) ->
  socket.emit 'joined'
  socket.on 'moveSubmission', (data) ->
    console.log data

# start server
server.listen app.get('port'), () ->
  console.log("Express server listening on port " + app.get('port'));