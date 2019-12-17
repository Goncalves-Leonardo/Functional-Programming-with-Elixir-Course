defmodule FriendsApp.CLI.Menu.Choice do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.CLI.Menu.Itens

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opcao: ")

    menu_itens = Itens.all()

    find_menu_item_by_index = &Enum.at(menu_itens, &1, :error)

    menu_itens
    |> Enum.map(&(&1.label))
    |> display_options()
    |> generate_question()
    |> Shell.prompt
    |> parse_answer()
    |> find_menu_item_by_index.()
    |> confirm_menu_item()
    |> confirm_message()

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
    case Integer.parse(answer) do
      :error -> invalid_option()
      {option, _} -> option - 1
    end
  end

  defp confirm_menu_item(item) do
    case item do
      :error -> invalid_option()
      _ -> item
    end
  end

  defp confirm_message(item) do
    Shell.cmd("clear")
    Shell.info("Você escolheu... [#{item.label}]")

    if Shell.yes?("Confirma?") do
      Shell.info("...[#{item.label}]")
    else
      start()
    end
  end

  defp invalid_option do
    Shell.cmd("clear")
    Shell.error("Opção inválida!")
    Shell.prompt("Pressione ENTER para tentar novamente.")
    start()
  end
end
