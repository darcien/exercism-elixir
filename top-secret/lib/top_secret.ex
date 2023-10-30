defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _meta, args} = ast, acc)
      when op == :def or op == :defp do
    {fn_name, fn_args} = get_function_name_and_args(args)

    fn_arity = length(fn_args)

    message_part =
      fn_name
      |> to_string()
      |> String.slice(0, fn_arity)

    {ast, [message_part | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp get_function_name_and_args(def_args) do
    [fn_header | _rest] = def_args

    case fn_header do
      {:when, _, guard_args} -> get_function_name_and_args(guard_args)
      {name, _, args} when is_list(args) -> {name, args}
      {name, _, _} -> {name, []}
    end
  end

  defp get_fn_ast_list_from_block({:__block__, _, args}) do
    case args do
      list when is_list(list) ->
        list
        |> Enum.flat_map(fn node ->
          case node do
            {:defmodule, _, _} -> get_fn_list_from_module_def(node)
            {:def, _, _} -> [node]
            {:defp, _, _} -> [node]
            _ -> []
          end
        end)

      _ ->
        []
    end
  end

  defp get_fn_list_from_do_arg(do_arg) do
    case do_arg do
      {:__block__, _, list} when is_list(list) -> list
      {:def, _, _} -> [do_arg]
      {:defp, _, _} -> [do_arg]
      _ -> []
    end
  end

  defp get_fn_list_from_module_def({:defmodule, _, module_args}) when is_list(module_args) do
    [_module_header_line, module_body] = module_args

    if is_list(module_body) do
      module_body
      |> Keyword.get(:do)
      |> get_fn_list_from_do_arg()
    else
      []
    end
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> List.wrap()
    # Ideally this should use something like
    # `Macro.prewalk/3` to traverse the AST
    # instead of hardcoding the AST shape here.
    # e.g. https://exercism.org/tracks/elixir/exercises/top-secret/solutions/angelikatyborska
    # AST explorer: https://ast.ninja/
    |> Enum.flat_map(fn node ->
      case node do
        {:__block__, _, _} ->
          get_fn_ast_list_from_block(node)

        {:defmodule, _, _} ->
          get_fn_list_from_module_def(node)
      end
    end)
    |> Enum.reduce([], fn ast, acc ->
      {_, new_acc} = decode_secret_message_part(ast, acc)
      new_acc
    end)
    |> Enum.reverse()
    |> Enum.join()
  end
end
