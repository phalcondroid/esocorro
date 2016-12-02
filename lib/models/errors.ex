defmodule Esocorro.Models.Errors do
    alias Esocorro.Db.MongoPool

    @collection "bz_errors"

    def get_errors(conditions) do
        cursor = Mongo.find(MongoPool, @collection, conditions)
        Enum.to_list(cursor)
    end

    def new(map) do

		insert_result = Mongo.insert_one(
            MongoPool,
            "bz_errors",
            map
        )

        case insert_result do

            {:ok, %Mongo.InsertOneResult{inserted_id: error_id}} ->
                case is_map(Frontend.register(error_id, error_type, content_body)) do
                    true  ->
                        send_slack_message(socorro_id, error_type, 1, build)
                        Logger.info "Error report saved succesfully"
                    false ->
                        Logger.error "Insert error report failed"
                end
            _ ->
                Logger.error "Insert Errors collection failed"
        end
    end
end
