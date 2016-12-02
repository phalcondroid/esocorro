defmodule Socorro.Db.MongoPool do
    alias Socorro.Db.MongoPool
    use Mongo.Pool, name: __MODULE__, adapter: Mongo.Pool.Poolboy, size: 10

    def connect() do

        hostname = Application.fetch_env!(:mongodb, :hostname)
        database = Application.fetch_env!(:mongodb, :database)
        username = Application.fetch_env!(:mongodb, :username)
        password = Application.fetch_env!(:mongodb, :password)

        if username != "" && password != "" do
            MongoPool.start_link(hostname: hostname, database: database, username: username, password: password)
        else
            MongoPool.start_link(hostname: hostname, database: database)
        end
    end
end
