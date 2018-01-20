defmodule FactFluencyWeb.TestView do
  use FactFluencyWeb, :view

  def generate_numbers() do
    Enum.to_list(0..12)
  end
end
