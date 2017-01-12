defmodule Assignment do

  alias Naranjo.Weekday

  def process(params) do
    # IO.inspect params
    students = params["students"]
      |> Map.values
      |> Enum.map(&replace_hours/1)
    teachers = params["teachers"]
      |> Map.values
      |> Enum.map(&replace_hours/1)
    rooms = params["rooms"]
      |> Map.values
      |> Enum.map(&replace_hours/1)

    {:ok, results} = Agent.start_link(fn -> [] end)
    check_students(%{s: students, t: teachers, r: rooms, acc: [], results: results})
    n = Agent.get(results, fn(n) -> n end)
    Enum.at(n, -1)
  end

  defp replace_hours(obj) do
    obj |> Map.merge(%{"hours" => Weekday.reference_hours(obj["hours"])})
  end

  def check_students(%{s: [student | _tail]} = state) do
    check_hours(student, state)
  end
  def check_students(%{acc: acc, results: results}) do
    Agent.update(results, fn(r) ->
      [acc | r]
    end)
  end

  def check_hours(student, state) do
    hor = Enum.with_index(student["hours"])
    Enum.each(hor, fn({available, hour}) ->
      if available do
        check_teachers(hour, student, state)
      end
    end)
  end

  def check_teachers(hour, student, state) do
    Enum.each(state.t, fn(teacher) ->
      if Enum.at(teacher["hours"], hour) do
        check_rooms(teacher, hour, student, state)
      end
    end)
  end

  def check_rooms(teacher, hour, student, state) do
    Enum.each(state.r, fn(room) ->
      if Enum.at(room["hours"], hour) do
        new_state(room, teacher, hour, student, state)
          |> check_students
      end
    end)
  end

  def new_state(room, teacher, hour, student, state) do
    tea = remove_hour(hour, teacher)
    room = remove_hour(hour, room)

    %{
      s: List.delete(state.s, student),
      t: [tea | List.delete(state.t, teacher)],
      r: [room | List.delete(state.r, room)],
      acc: [%{student: student, teacher: teacher, room: room, hour: hour} | state.acc ],
      results: state.results
    }
  end


  def remove_hour(hour, obj) do
    %{obj | "hours" => List.replace_at(obj["hours"], hour, false)}
  end

  def get_hours(hour) do
    ["9am", "10am", "11am", "12pm", "2pm", "3pm", "4pm", "5pm", "6pm"]
      |> Enum.at(hour)
  end


  def test do

    students = [
      %{
        name: "student 1",
        hours: [0,0,0,0,1,1,1,1,0],
        last_pr: []
      },
      %{
        name: "student 2",
        hours: [1,1,1,1,1,1,1,1,1],
        last_pr: []
      },
      %{
        name: "student 3",
        hours: [1,1,0,0,0,1,1,1,1],
        last_pr: ["teacher 1"]
      },
      %{
        name: "student 4",
        hours: [1,1,0,0,0,1,1,1,1],
        last_pr: []
      }
    ]

    # 3,2,1,4
    teachers = [
      %{
        name: "teacher 1",
        hours: [0,1,1,1,0,0,0,0,0]
      },
      %{
        name: "teacher 2",
        hours: [0,0,0,1,1,1,0,0,0]
      }
    ]

    rooms = [
      %{
        name: "Sala A",
        hours: [1,1,1,1,1,1,1,1,1]
      }
    ]

    initial_state = %{al: students, pr: teachers, sa: rooms, acc: []}

    check_students(initial_state)
  end


end

# Assignment.test
