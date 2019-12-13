defmodule FriendsApp.CLI.MenuChoice do
  alias Mix.Shell.IO, as: Shell
  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opcao: ")

    menu_itens = FriendsApp.CLI.MenuItens.all()

    find_menu_item_by_index = &Enum.at(menu_itens, &1)

    menu_itens
    |> Enum.map(&(&1.label))
    |> display_options()
    |> generate_question()
    |> Shell.prompt
    |> parse_answer()
    |> find_menu_item_by_index.()
    |> confirm_menu_item()

  end

  defp display_options(ops) do
    ops
    |> Enum.with_index(1)
    |> Enum.each(fn {op,index} -> Shell.info("#{index} - #{op}") end)
    ops
  end

  defp generate_question(ops) do
    ops = Enum.join(1..Enum.count(ops),",")
    "Qual das opções acima você escolhe? [#{ops}]\n"
  end

  defp parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
  end

  defp confirm_menu_item(item) do
    Shell.cmd("clear")
    Shell.info("Você escolheu... [#{item.label}]")

    if Shell.yes?("Confirma?") do
      Shell.info("...[#{item.label}]")
    else
      start()
    end
  end
end
