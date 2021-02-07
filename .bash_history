ll
ls -al 
mix ecto.create
mix phx.server
mix deps.get
mix deps.compile
mix phx.server
MIX_ENV=dev mix phx.server
MIX_ENV=dev mix ecto.create
MIX_ENV=dev mix phx.server
