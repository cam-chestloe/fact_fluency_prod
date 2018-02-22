defmodule FactFluencyWeb.TestCommander do
  use Drab.Commander

  alias FactFluency.Testing

  access_session([:test_id])
 
  def start_test(socket, _sender) do
    test = get_session(socket, :test_id) |> Testing.get_test!()
      |> Testing.start_question(0)

    put_store(socket, :test, test)

    set_style(socket, "#start-test-confirmation", %{"display" => "none"})
  end

  def answer_question(socket, _sender) do
    {:ok, %{"value" => answer}} = query_one(socket, "#answer-input", "value")
    index = peek(socket, :index)

    test = get_store(socket, :test, nil)
      |> Testing.answer_question(index, answer)

    case Enum.fetch(test.questions, index + 1) do
      {:ok, question} ->
        
        put_store(socket, :test, 
          Testing.start_question(test, index + 1))

        poke(socket, question: question, index: index + 1)

      :error ->
        FactFluency.Testing.update_test(test, %{questions: test.questions})
        FactFluency.Testing.grade_test(test.id)
        Drab.Browser.redirect_to(socket, "/tests/#{test.id}")
    end

    set_prop(socket, "#answer-input", %{"value" => ""})
  end
end