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

    def submit_login(socket, %{"dataset" => %{"btnFor" => user_type}}) do
        %{"value" => email}  = query_one!(socket, "##{user_type}-login-email input", :value)
        %{"value" => password} = query_one!(socket, "##{user_type}-login-password input", :value)

        case FactFluency.Accounts.authenticate_by_email_password(email, password, user_type) do
            {:ok, user} ->
                set_attr(socket, "#session-email", value: email)
                set_attr(socket, "#session-password", value: password)
                set_attr(socket, "#session-user-type", value: user_type)
                exec_js!(socket, "document.forms.namedItem('session-form').submit()")

            {:error, :unauthorized} ->
                set_prop(socket, "##{user_type}-login-password p", innerHTML: "Invalid username and #{user_type === "Student" && "PIN" || "password"}.")
        end
    end
end 