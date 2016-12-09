defmodule Socorro do
	
    use Application
    
    alias Socorro.Core.{ Pool }
    alias Socorro.Db.MongoPool
    alias Socorro.Core.ErrorException

    def start(_type, _args) do
        MongoPool.connect()
        Pool.start_link
    end

    def config(url, key) do
        Application.put_env :eerrors, :errors_url, url
        Application.put_env :eerrors, :private_key, key
    end

    def send_report(report) do
        try do
            Pool.report(%{
                "report"    => report
            })
        rescue 
            e -> ErrorException.set_exception(e)
        catch 
            e -> ErrorException.set_exception(e)
        end
    end
end
