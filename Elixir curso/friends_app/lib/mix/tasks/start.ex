defmodule Mix.Tasks.Start do
  use Mix.Task

  @shortdoc "Friends App Start"
  def run(_), do: FriendsApp.CLI.Main.start_app
end
