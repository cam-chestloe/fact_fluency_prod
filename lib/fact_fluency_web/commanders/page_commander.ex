defmodule FactFluencyWeb.PageCommander do
    use Drab.Commander

    def show_modal(socket, %{"dataset" => %{"btnFor" => name}} = sender) do
        set_style(socket, "##{name}-modal", display: "block")
    end

    def hide_modal(socket, %{"dataset" => %{"btnFor" => name}} = sender) do
        set_style(socket, "##{name}-modal", display: "none")
    end

    def change_signup_form(socket,  %{"value" => user_type} = sender) do
        conn = peek(socket, "signup.html", :conn)
        
        set_prop(socket, "#login-form", FactFluencyWeb.PageView.render_signup_form(user_type, conn))
    end
end