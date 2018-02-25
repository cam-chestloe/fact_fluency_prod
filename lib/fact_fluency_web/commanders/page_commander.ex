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

        other_user_types = ["Teacher-signup", "Student-signup", "Parent-signup"] -- ["#{current_user_type}-signup"]

        show_modal(socket, "#{current_user_type}-signup")
        hide_modal(socket, other_user_types)
    end

    def submit_login(socket, %{"dataset" => %{"btnFor" => user_type}}) do
        %{"value" => email}  = query_one!(socket, "##{user_type}-login-email input", :value)
        %{"value" => password} = query_one!(socket, "##{user_type}-login-password input", :value)

        case FactFluency.Accounts.authenticate_by_email_password(email, password, user_type) do
            {:ok, _user} ->
                exec_js!(socket, "document.forms.namedItem('#{user_type}-session-form').submit()")

            {:error, :unauthorized} ->
                set_style(socket, "##{user_type}-login-password p", visibility: "visible")
        end
    end
end 