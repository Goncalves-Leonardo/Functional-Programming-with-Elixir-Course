defmodule Mix.Tasks.Utils.AddFakeFriends do
  use Mix.Task
  alias NimbleCSV.RFC4180, as: CSVparser

  @shortdoc "Add Fake Friends on Application"
  def run(_) do
    Faker.start()
    create_friends([],50)
    |> CSVparser.dump_to_iodata()
    |> save_csv_file()
  end

  defp create_friends(list,count) when count <= 1 do
    list ++ [random_list_friend]
  end

  defp create_friends(list,count) do
    list ++ [random_list_friend] ++ create_friends(list, count - 1)
  end

  defp random_list_friend do
    [
      Faker.Name.PtBr.name(),
      Faker.Internet.email(),
      Faker.Phone.EnUs.phone()
    ]
  end

  defp save_csv_file(data) do
    File.write!("#{File.cwd!}/friends.csv", data, [:append])
  end
end
