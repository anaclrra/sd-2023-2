defmodule UsuariosTarefas do
  alias UsuariosCrud, as: Crud

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
end
