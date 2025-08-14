defmodule IoTFleet.DeviceSimulator do
  def start(num \\ 10) do
    Enum.each(1..num, fn id ->
      spawn(fn -> loop(id) end)
    end)
  end

  defp loop(id) do
    temp = :rand.uniform(20) + 10
    payload = Jason.encode!(%{device_id: id, temperature: temp})
    :httpc.request(
      :post,
      {"http://localhost:4000/telemetry", [], "application/json", payload},
      [],
      []
    )
    :timer.sleep(:rand.uniform(2000))
    loop(id)
  end
end
