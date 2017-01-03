
use "get_nth.sml";

fun int_to_month(n : int) =
  let
    val months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]
  in
    get_nth(months, n)
  end

