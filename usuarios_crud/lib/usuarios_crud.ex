defmodule UsuariosCrud do
  def iniciar_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def adicionar_usuario(nome, email) do
    Agent.update(__MODULE__, fn usuarios ->
      id = length(usuarios) + 1
      novo_usuario = %{id: id, nome: nome, email: email}
      usuarios ++ [novo_usuario]
    end)
  end

  def listar_usuarios do
    Agent.get(__MODULE__, fn usuarios -> usuarios end)
  end

  def atualizar_usuario(id, novos_atributos) do
    Agent.update(__MODULE__, fn usuarios ->
      Enum.map(usuarios, fn usuario ->
        if usuario.id == id do
          Map.merge(usuario, novos_atributos)
        else
          usuario
        end
      end)
    end)
  end

  def remover_usuario(id) do
    Agent.update(__MODULE__, fn usuarios ->
      Enum.reject(usuarios, &(&1.id == id))
    end)
  end
end
