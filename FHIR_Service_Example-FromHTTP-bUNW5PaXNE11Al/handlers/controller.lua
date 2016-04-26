local Handlers = {}

Handlers.handleGet    = require 'handlers.types.get'
Handlers.handlePut    = require 'handlers.types.put'
Handlers.handlePost   = require 'handlers.types.post'
Handlers.handleDelete = require 'handlers.types.delete'

return Handlers
