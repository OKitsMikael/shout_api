{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start
ExUnit.configure exclude: [:pending, :broken], trace: true
Ecto.Adapters.SQL.Sandbox.mode(ShoutApi.Repo, :manual)

