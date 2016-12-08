
defmodule Socorro.Core.Pool do
    alias Socorro.Core.Worker

    def start_link() do
        config = [
            {:name, {:local, :uploaders_esocorro_module}},
            {:worker_module, Worker},
            {:size, 10},
            {:max_overflow, 5}
        ]

        children = [
            :poolboy.child_spec(:uploaders_esocorro_module, config, [])
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
                :uploaders_esocorro_module,
                fn pid -> Worker.report(pid, payload) end,
                :infinity
            )
        end
    end
end
