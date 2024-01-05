defmodule UsuariosTarefas do
  alias UsuariosCrud, as: Crud

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

  def adicionar_usuario(nome, email) do
    Task.async(fn -> Crud.adicionar_usuario(nome, email) end)
  end

  def listar_usuarios() do
    Task.async(fn -> Crud.listar_usuarios() end)
  end

  def atualizar_usuario(id, novos_atributos) do
    Task.async(fn -> Crud.atualizar_usuario(id, novos_atributos) end)
  end

  def remover_usuario(id) do
    Task.async(fn -> Crud.remover_usuario(id) end)
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
    |> Task.await()
    IO.puts("Usuário adicionado com sucesso.")
  end

  defp listar do
    IO.puts("Lista de usuários:")
    listar_usuarios()
    |> Task.await()
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
    |> Task.await()
    IO.puts("Usuário atualizado com sucesso.")
  end

  defp excluir do
    IO.puts("Digite o ID do usuário a ser removido:")
    id = IO.gets("") |> String.trim() |> String.to_integer()
    remover_usuario(id)
    |> Task.await()
    IO.puts("Usuário removido com sucesso.")
  end
end
