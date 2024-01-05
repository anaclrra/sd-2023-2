defmodule UsuariosCrud do
  @menu """
  Menu do sistema
  =============
  1. Criar
  2. Listar
  3. Atualizar
  4. Excluir
  5. Sair
  Entre com sua opção:
  """

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

  def principal() do
    op = IO.gets(@menu)
         |> String.trim()
         |> String.to_integer()

    case op do
      1 -> criar()
      2 -> listar()
      3 -> alterar()
      4 -> excluir()
      5 -> IO.puts("Até logo")
      _ -> IO.puts("Opção inválida")
    end

    unless op == 5, do: principal()
  end

  defp criar do
    IO.puts("Digite o nome do usuário:")
    nome = IO.gets("") |> String.trim()
    IO.puts("Digite o email do usuário:")
    email = IO.gets("") |> String.trim()
    adicionar_usuario(nome, email)
    IO.puts("Usuário adicionado com sucesso.")
  end

  defp listar do
    IO.puts("Lista de usuários:")
    listar_usuarios()
    |> Enum.each(fn %{id: id, nome: nome, email: email} ->
      IO.puts("ID: #{id}, Nome: #{nome}, Email: #{email}")
    end)
  end

  defp alterar do
    IO.puts("Digite o ID do usuário a ser atualizado:")
    id = IO.gets("") |> String.trim() |> String.to_integer()
    IO.puts("Digite o novo nome (deixe em branco para não alterar):")
    nome = IO.gets("") |> String.trim()
    IO.puts("Digite o novo email (deixe em branco para não alterar):")
    email = IO.gets("") |> String.trim()
    novos_atributos = Enum.filter([nome: nome, email: email], fn {_, v} -> v != "" end) |> Enum.into(%{})
    atualizar_usuario(id, novos_atributos)
    IO.puts("Usuário atualizado com sucesso.")
  end

  defp excluir do
    IO.puts("Digite o ID do usuário a ser removido:")
    id = IO.gets("") |> String.trim() |> String.to_integer()
    remover_usuario(id)
    IO.puts("Usuário removido com sucesso.")
  end
end
