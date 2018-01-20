defmodule FactFluencyWeb.TestCommander do
  use Drab.Commander

  alias FactFluency.Testing

  access_session([:test_id])

  def answer_question(socket, _sender) do
    index = peek(socket, :index)
    answer = peek(socket, :answer)

    test =
      (index === 1 && get_store(socket, :test, nil)) ||
        get_session(socket, :test_id) |> Testing.get_test!()
        |> Testing.answer_question(index, answer)

    case Enum.fetch(test.questions, index + 1) do
      {:ok, question} ->
        put_store(socket, :test, test)
        poke(socket, question: question, index: index + 1, answer: "")

      :error ->
        FactFluency.Testing.update_test(test, %{})
        Drab.Browser.redirect_to(socket, "/tests/#{test.id}")
    end
  end
end