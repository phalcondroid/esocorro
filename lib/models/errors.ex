defmodule Socorro.Models.Errors do
    alias Socorro.Db.MongoPool

    require Logger

    @collection "bz_errors"

    def get_errors(conditions) do
        cursor = Mongo.find(MongoPool, @collection, conditions)
        Enum.to_list(cursor)
    end

    def new(connection, map) do
        Mongo.insert_one(
            connection,
            @collection,
            map
        )
    end

    def check_insert_result(insert_result) do
        case insert_result do
            {:ok, %Mongo.InsertOneResult{inserted_id: error_id}} ->
                error_id
            _ ->
                Logger.error "Insert error report failed"
                false
        end
    end 

    def check_result_update(result_update) do
        case result_update do
            {:ok, _} ->
                Logger.info "Update error Succesfully "
                true
            _ ->
                Logger.error "Update error failed"
                false
        end
    end
end
