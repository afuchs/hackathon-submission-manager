module.exports = 
  class Hacker
  	constructor: (params={}) ->
      name = params.name or undefined
      email = params.email or undefined 
      role = params.role or 'developer'