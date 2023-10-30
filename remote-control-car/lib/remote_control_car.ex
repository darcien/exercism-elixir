defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car) when is_struct(remote_car, RemoteControlCar) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car) when is_struct(remote_car, RemoteControlCar) do
    case remote_car.battery_percentage do
      0 -> "Battery empty"
      x -> "Battery at #{x}%"
    end
  end

  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) do
    case remote_car.battery_percentage do
      0 ->
        remote_car

      x ->
        %{
          remote_car
          | battery_percentage: x - 1,
            distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
        }
    end
  end
end
