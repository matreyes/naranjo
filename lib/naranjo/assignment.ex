defmodule Assignment do

  def test do

    alumnos = [
      %{
        nombre: "Alumno 1",
        horarios: [0,0,0,0,1,1,1,1,0],
        last_pr: []
      },
      %{
        nombre: "Alumno 2",
        horarios: [1,1,1,1,1,1,1,1,1],
        last_pr: []
      },
      %{
        nombre: "Alumno 3",
        horarios: [1,1,0,0,0,1,1,1,1],
        last_pr: ["Profesor 1"]
      },
      %{
        nombre: "Alumno 4",
        horarios: [1,1,0,0,0,1,1,1,1],
        last_pr: []
      }
    ]

    # 3,2,1,4
    profesores = [
      %{
        nombre: "Profesor 1",
        horarios: [0,1,1,1,0,0,0,0,0]
      },
      %{
        nombre: "Profesor 2",
        horarios: [0,0,0,1,1,1,0,0,0]
      }
    ]

    salas = [
      %{
        nombre: "Sala A",
        horarios: [1,1,1,1,1,1,1,1,1]
      }
    ]

    initial_state = %{al: alumnos, pr: profesores, sa: salas, acc: []}

    check_alumnos(initial_state)
  end



  def check_alumnos(%{al: [alumno | _tail]} = state) do
    check_horarios(alumno, state)
  end
  def check_alumnos(%{acc: acc}) do
    IO.puts "\n\n"
    IO.inspect acc
    IO.puts "\n\n"
  end

  def check_horarios(alumno, state) do
    hor = Enum.with_index(alumno.horarios)
    Enum.each(hor, fn({disponible, hora}) ->
      if is?(disponible) do
        check_profesores(hora, alumno, state)
      end
    end)
  end

  def check_profesores(hora, alumno, state) do
    # IO.inspect state.pr
    Enum.each(state.pr, fn(profesor) ->
      if is?(Enum.at(profesor.horarios, hora)) and !Enum.member?(alumno.last_pr, profesor.nombre) do
        check_salas(profesor, hora, alumno, state)
      end
    end)
  end

  def check_salas(profesor, hora, alumno, state) do
    Enum.each(state.sa, fn(sala) ->
      if is?(Enum.at(sala.horarios, hora)) do
        update_state(sala, profesor, hora, alumno, state)
          |> check_alumnos
      end
    end)
  end

  def update_state(sala, profesor, hora, alumno, state) do
    pr = remove_hora(hora, profesor)
    sa = remove_hora(hora, sala)

    %{state |
      al: List.delete(state.al, alumno),
      pr: [pr | List.delete(state.pr, profesor)],
      sa: [sa | List.delete(state.sa, sala)],
      acc: [[alumno.nombre, profesor.nombre, sala.nombre, hora] | state.acc ]
    }
  end

  def is?(x) do
    x == 1
  end

  def remove_hora(hora, obj) do
    %{obj | horarios: List.replace_at(obj.horarios, hora, 0)}
  end

  def get_horas(hora) do
    ["9am", "10am", "11am", "12pm", "2pm", "3pm", "4pm", "5pm", "6pm"]
      |> Enum.at(hora)
  end
end

# Assignment.test
