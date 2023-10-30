defmodule PaintByNumber do
  defp bit_size_check(size, count) do
    if 2 ** size >= count do
      size
    else
      bit_size_check(size + 1, count)
    end
  end

  def palette_bit_size(color_count) do
    bit_size_check(0, color_count)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count) do
    nil
  end

  def get_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<first_pixel::size(palette_size), _rest::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(<<>>, _color_count) do
    <<>>
  end

  def drop_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<_first_pixel::size(palette_size), rest::bitstring>> = picture
    <<rest::bitstring>>
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
