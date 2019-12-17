defmodule FriendsApp.CLI.Menu.Itens do
  alias FriendsApp.CLI.Menu, as: Menu

  def all, do: [
    %Menu{label: "Cadastrar um amigo", id: :create},
    %Menu{label: "Listar os amigos", id: :read},
    %Menu{label: "Atualizar um amigo", id: :update},
    %Menu{label: "Deletar um amigo", id: :delete}
  ]
end
