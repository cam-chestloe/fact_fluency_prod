defmodule FactFluencyWeb.TestView do
  use FactFluencyWeb, :view

  def parse_question(question, type) do
    [top, operator, bottom] = String.split(question)

    case type do
      :top -> top
      :operator -> operator
      :bottom -> bottom
    end
  end
end
