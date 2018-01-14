defmodule FactFluencyWeb.TestCommander do
  use Drab.Commander
  
  access_session [:test_id]

  def answer_question(socket, _sender) do
    test = get_store(socket, :test, nil) || FactFluency.Testing.get_test!(get_session(socket, :test_id))
    question = peek(socket, :question)
    index = peek(socket, :index)
    answer = peek(socket, :answer)

    test = 
    Map.update!(test, :questions, fn(questions) ->
      List.update_at(questions, index, fn(q) ->
        %{q | student_answer: answer}
      end)
    end)

    case Enum.fetch(test.questions, index + 1) do
      {:ok, question} ->
        poke(socket, question: question, index: index + 1, answer: "")
      :error ->
        FactFluency.Testing.update_test(test, %{questions: test.questions, end_time: DateTime.utc_now()})
        Drab.Browser.redirect_to(socket, "/tests/show/#{test.id}")
      end
  end

  def skip(socket, _sender) do
    index = peek(socket, :index)
    poke(socket, index: index + 1)
  end
end
