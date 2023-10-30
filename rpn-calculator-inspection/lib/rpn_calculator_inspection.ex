defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, sender_pid, :normal} when sender_pid == pid ->
        Map.put(results, input, :ok)

      {:EXIT, sender_pid, _} when sender_pid == pid ->
        Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    prev_trap_exit = Process.flag(:trap_exit, true)

    final_results =
      inputs
      |> Enum.map(fn input ->
        start_reliability_check(calculator, input)
      end)
      |> Enum.reduce(%{}, fn reli_check, results ->
        await_reliability_check_result(reli_check, results)
      end)

    Process.flag(:trap_exit, prev_trap_exit)

    final_results
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input ->
      Task.async(fn -> calculator.(input) end)
    end)
    |> Task.await_many(100)
  end
end
