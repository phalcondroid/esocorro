defmodule Socorrro.Models.BackgroundError do
	alias Socorro.Db.MongoPool

    require Logger
	
	@collection "bz_background_error"

	def new(map) do
		Mongo.insert_one(
            MongoPool,
            @collection,
            map
        )
	end
end