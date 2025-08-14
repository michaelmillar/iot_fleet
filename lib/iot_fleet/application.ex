defmodule IoTFleet.Application do
    use Application

    def start(_type, _args) do
        children = [
            {IoTFleet.Server, []}
        ]

        opts = [strategy: :one_for_one, name: IoTFleet.Supervisor]
        Supervisor.start_link(children, opts)
    end
end