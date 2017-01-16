defmodule Naranjo.Email do
  use Bamboo.Phoenix, view: Naranjo.EmailView
  alias Naranjo.History

  def student_schedule(%History{student: student, schedule: schedule}) do
    day = Timex.format!(schedule, "%d/%m/%Y",:strftime)
    hour = Timex.format!(schedule, "%H:%M",:strftime)
    new_email
      |> to(student.email)
      |> from("horarios.nei@gmail.com")
      |> subject("Horario interrogación #{day}")
      |> text_body("Estimado(a) #{student.name}.\n\n Se ha reservado una interrogación para el día #{day} a las #{hour} horas.\n\nAtte, Naranjo e Ibarrola")
  end

end
