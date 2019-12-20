defmodule FriendsApp.DB.CSV do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.CLI.Menu
  alias FriendsApp.CLI.Friend
  alias NimbleCSV.RFC4180, as: CSVparser

  def perform(chosen_menu_item) do
    case chosen_menu_item do
       %Menu{ id: :create, label: _ } -> create()
       %Menu{ id: :update, label: _ } -> Shell.info(">>>>>>>>>> UPDATE <<<<<<<<<<")
       %Menu{ id: :delete, label: _ } -> Shell.info(">>>>>>>>>> DELETE <<<<<<<<<<")
       %Menu{ id: :read, label: _ } -> read()
    end
    FriendsApp.CLI.Menu.Choice.start()
  end

  defp read do
    get_struct_list_from_csv()
    |> show_friends()
  end

  defp get_struct_list_from_csv do
    read_csv_file()
    |> csv_list_to_friend_struct_list()
  end

  defp csv_list_to_friend_struct_list(struct_list) do
    struct_list
    |> Enum.map( fn [email, name, phone] ->
      %Friend{name: name, email: email, phone: phone}
    end)
  end

  defp read_csv_file() do
    File.read!("#{File.cwd!}/friends.csv")
    |> parse_csv_file_to_list()
  end

  defp parse_csv_file_to_list(csv_file) do
    csv_file
    |> CSVparser.parse_string(headers: false)
  end

  defp show_friends(friends) do
    friends
    |> Scribe.console(data: [{"Nome", :name},{"Email", :email},{"Telefone", :phone}])
  end

  defp create do
    collect_data
    |> transform_on_wrapped_list()
    |> prepare_list_to_save_csv()
    |> save_csv_file([:append])
  end

  defp collect_data do
    Shell.cmd("clear")
    %Friend{
      name: prompt_message("Digite o nome: "),
      email: prompt_message("Digite o email: "),
      phone: prompt_message("Digite o telefone: ")
    }
  end


  defp transform_on_wrapped_list(struct) do
    struct
    |> Map.from_struct
    |> Map.values
    |> wrap_in_list
  end

  defp prepare_list_to_save_csv(list) do
    list
    |> CSVparser.dump_to_iodata()
  end

  defp prompt_message(message) do
    Shell.prompt(message)
    |> String.trim
  end

  defp wrap_in_list(list) do
    [list]
  end

  defp save_csv_file(data, mode \\ []) do
    File.write!("#{File.cwd!}/friends.csv", data, mode)
  end
end
