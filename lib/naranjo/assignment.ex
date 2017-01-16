defmodule Assignment do

  alias Naranjo.Weekday

  def get_state(pid) do
    Agent.get(pid, fn(n) -> n end)
  end

  def process(params) do
    students = params["students"]
      |> Map.values
      |> Enum.map(&replace_hours/1)
    teachers = params["teachers"]
      |> Map.values
      |> Enum.map(&replace_hours/1)
    rooms = params["rooms"]
      |> Map.values
      |> Enum.map(&replace_hours/1)

    now = :os.system_time(:seconds)
    {:ok, a_pid} = Agent.start_link(fn -> {[],0,now} end)
    check_students(%{s: students, t: teachers, r: rooms, acc: [], a_pid: a_pid})
    {results, _, _} = full_state = get_state(a_pid)
    Enum.at(results, -1)
  end

  defp replace_hours(obj) do
    obj |> Map.merge(%{"hours" => Weekday.reference_hours(obj["hours"])})
  end

  def check_students(%{s: [student | _tail]} = state) do
    {_, results_number, time} = get_state(state.a_pid)
    seconds = :os.system_time(:seconds) - time
    if results_number < 3 and (seconds < 10 or results_number < 1) and seconds < 300 do
      check_hours(student, state)
    end
  end
  def check_students(%{acc: acc, a_pid: a_pid}) do
    Agent.update(a_pid, fn({r,n,time}=st) ->
      if n < 3 do
        {[acc | r], n+1, time}
      else
        st
      end
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
    a_teachers = case student["teacher"] do
      t when is_list(t) ->
        state.t |> Enum.reject(fn(x) -> Enum.member?(t, x["id"]) end)
      _ -> state.t
    end
    Enum.each(a_teachers, fn(teacher) ->
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
    ro = remove_hour(hour, room)

    %{
      s: List.delete(state.s, student),
      t: [tea | List.delete(state.t, teacher)],
      r: [ro | List.delete(state.r, room)],
      acc: [%{student: student, teacher: teacher, room: room, hour: hour} | state.acc ],
      a_pid: state.a_pid
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
