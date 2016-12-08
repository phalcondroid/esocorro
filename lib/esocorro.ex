defmodule Socorro do
	
    use Application
    
    alias Socorro.Core.{ Pool }
    alias Socorro.Db.MongoPool

    def start(_type, _args) do
        MongoPool.connect()
        Pool.start_link
    end

    def config(url, key) do
        Application.put_env :eerrors, :errors_url, url
        Application.put_env :eerrors, :private_key, key
    end

    def send_report(report) do
        Pool.report(%{
            "report"    => report
        })
    end
end
