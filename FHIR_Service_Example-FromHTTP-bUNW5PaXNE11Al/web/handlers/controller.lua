local Handlers = {}

Handlers.handleGet    = require 'web.handlers.types.get'
Handlers.handlePut    = require 'web.handlers.types.put'
Handlers.handlePost   = require 'web.handlers.types.post'
Handlers.handleDelete = require 'web.handlers.types.delete'

return Handlers
