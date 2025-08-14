defmodule IoTFleet.Server do
    use Plug.Router

    plug :match
    plug Plug.Parsers,
        parsers: [:json],
        pass:   ["application/json"],
        json_decoder: Jason
    plug :dispatch

    post "/telemetry" do
        IO.puts("Device #{conn.body_params["device_id"]} -> Temp #{conn.body_params["temperature"]}")
        #IO.inspect(conn.body_params, label: "Telemetry received")
        send_resp(conn, 200, Jason.encode!(%{status: "ok"}))
    end

    match _ do
        send_resp(conn, 404, "Not found")
    end

    def start_link(_) do
        Plug.Cowboy.http(__MODULE__, [], port: 4000)

    end
end


# IoTFleet.DeviceSimulator.start(5)