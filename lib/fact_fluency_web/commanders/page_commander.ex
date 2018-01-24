defmodule FactFluencyWeb.PageCommander do
    use Drab.Commander

    def show_modal(socket, sender) do
        change_modal_display(socket, sender, "block")
    end

    def hide_modal(socket, sender) do
        change_modal_display(socket, sender, "none")
    end

    def change_modal_display(socket, name, value) do
        case name do
            %{"dataset" => %{"btnFor" => name}} ->
                set_style(socket, "##{name}-modal", display: "#{value}")
            [name, tail] ->
                set_style(socket, "##{name}-modal", display: "#{value}")
                change_modal_display(socket, tail, value)
            name ->
                set_style(socket, "##{name}-modal", display: "#{value}")
        end
    end

    def change_signup_form(socket,  %{"value" => current_user_type} = sender) do
        set_prop(socket, this(sender), checked: "checked")

        other_user_types = ["teacher", "student", "parent"] -- [current_user_type]

        show_modal(socket, current_user_type)
        hide_modal(socket, other_user_types)
    end
end