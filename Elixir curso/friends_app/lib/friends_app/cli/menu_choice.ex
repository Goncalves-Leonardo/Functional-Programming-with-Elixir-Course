defmodule FriendsApp.CLI.MenuChoice do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opcao: ")

    FriendsApp.CLI.MenuItens.all()
    |> Enum.map(&(&1.label))
    |> display_options()

  end

  defp display_options(ops) do
    ops
    |> Enum.with_index(1)
    |> Enum.each(fn {op,index} -> Shell.info("#{index} - #{op}") end)
  end

end
