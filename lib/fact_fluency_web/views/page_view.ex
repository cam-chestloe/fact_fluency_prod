defmodule FactFluencyWeb.PageView do
  use FactFluencyWeb, :view

  def render_user_template(user_type, conn) do
    case user_type do
      "Teacher" -> 
        changeset = FactFluency.Teachers.change_teacher(%FactFluency.Teachers.Teacher{})
        assigns = [action: teacher_path(conn, :create), changeset: changeset, user_type: user_type]
        
        render(FactFluencyWeb.TeacherView, "form.html", assigns)

      "Student" -> 
        changeset = FactFluency.Students.change_student(%FactFluency.Students.Student{})
        assigns = [action: student_path(conn, :create), changeset: changeset, user_type: user_type]

        render(FactFluencyWeb.StudentView, "form.html", assigns)

      "Parent" -> 
        changeset = FactFluency.Parents.change_parent(%FactFluency.Parents.Parent{})
        assigns = [action: parent_path(conn, :create), changeset: changeset, user_type: user_type]

        render(FactFluencyWeb.ParentView, "form.html", assigns)
    end
  end
end
