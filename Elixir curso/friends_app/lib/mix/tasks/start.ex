defmodule Mix.Tasks.Start do
  use Mix.Task

  @shortdoc "Friends App Start"
  def run(_), do: FriendsApp.init
end
