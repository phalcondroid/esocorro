
defmodule Socorro.Core.Pool do
    alias Socorro.Core.Worker

    def start_link() do
        config = [
            {:name, {:local, :uploaders}},
            {:worker_module, Worker},
            {:size, 10},
            {:max_overflow, 5}
        ]

        children = [
            :poolboy.child_spec(:uploaders, config, [])
        ]

        options = [
            strategy: :one_for_one,
            name: Socorro.Core.Supervisor
        ]

        Supervisor.start_link(children, options)
    end

    def report(payload) do
        spawn fn ->
            :poolboy.transaction(
                :uploaders,
                fn pid -> Worker.report(pid, payload) end,
                :infinity
            )
        end
    end
end
