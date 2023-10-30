defmodule TakeANumber do
  @initial_count 0

  defp loop(count) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, count)
        loop(count)

      {:take_a_number, sender_pid} ->
        new_count = count + 1
        send(sender_pid, new_count)
        loop(new_count)

      :stop ->
        :ok

      _ ->
        loop(count)
    end
  end

  def start() do
    spawn(fn -> loop(@initial_count) end)
  end
end
