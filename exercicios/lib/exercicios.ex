defmodule Exercicios do

  def exibir_hello do
    IO.puts("Olá mundo!")
  end

  def exibir_nome(nome) do
    IO.puts("Olá, #{nome}!")
  end

  def exibir_dados(nome, idade) do
    IO.puts("Olá, #{nome}. Você tem #{idade} anos!")
  end

  def calcula_imc(nome, peso, altura_cm) do
    altura_m = altura_cm / 100
    imc = Float.round(peso / (altura_m * altura_m))

    IO.puts("Olá, #{nome}. Seu IMC é de #{imc}")
  end

  def invertidos(numeros) do
    inverte = Enum.reverse(numeros)
    IO.inspect(inverte)
  end

end
