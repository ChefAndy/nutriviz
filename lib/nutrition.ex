defmodule Nutrition do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Nutrition.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Nutrition.Endpoint, []),
      # Start your own worker by calling: Nutrition.Worker.start_link(arg1, arg2, arg3)
      # worker(Nutrition.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nutrition.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Nutrition.Endpoint.config_change(changed, removed)
    :ok
  end

  def ingest(data_dir) do
    if File.dir?(data_dir) and File.exists?(data_dir) do
      File.ls!(data_dir) |>
      Enum.map(fn (filename) -> File.stream!(data_dir <> "/" <> filename) |> IO.inspect() |>
        CSV.decode(separator: ?^) |>
        Enum.map(fn row ->
          Enum.map(row, &String.upcase/1)
        end)
      end)

    end
  end


end
