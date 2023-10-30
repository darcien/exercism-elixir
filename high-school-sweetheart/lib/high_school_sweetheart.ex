defmodule HighSchoolSweetheart do
  def first_letter(name), do: name |> String.trim() |> String.first()

  def initial(name), do: name |> first_letter() |> String.upcase() |> Kernel.<>(".")

  def initials(full_name) do
    full_name |> String.trim() |> String.split(" ") |> Enum.map(&initial/1) |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    template = """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     X. X.  +  X. X.     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """

    template
    |> String.replace("X. X.", initials(full_name1), global: false)
    |> String.replace("X. X.", initials(full_name2), global: false)
  end
end
