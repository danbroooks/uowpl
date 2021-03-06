
(* helper functions *)

fun contains(el: ''a, items: ''a list) =
  if null items
  then false
  else ((hd items) = el) orelse contains(el, tl items)

fun uniq(items: ''a list) =
  let
    fun recur(acc: ''a list, carry: ''a list) =
      if null carry
      then acc
      else if contains(hd carry, acc)
      then recur(acc, tl carry)
      else recur((hd carry)::acc, tl carry)
  in
    recur([], items)
  end

fun cast_bool_to_int(b : bool) = if b then 1 else 0

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

val days_in_month = [
  31, 28, 31,
  30, 31, 30,
  31, 31, 30,
  31, 30, 31
]

val days_in_month_leap = [
  31, 29, 31,
  30, 31, 30,
  31, 31, 30,
  31, 30, 31
]


(* 1 *)

fun is_older((y_a, m_a, d_a) : int * int * int, (y_b, m_b, d_b) : int * int * int) =
  (y_a < y_b)
  orelse (y_a = y_b andalso m_a < m_b)
  orelse (y_a = y_b andalso m_a = m_b andalso d_a < d_b)


(* 2 *)

fun number_in_month(months : (int * int * int) list, num : int) =
  if null months
  then 0
  else cast_bool_to_int(#2 (hd months) = num) + number_in_month(tl months, num)


(* 3 *)

fun number_in_months(months : (int * int * int) list, nums : int list) =
  if null nums
  then 0
  else number_in_month(months, hd nums) + number_in_months(months, tl nums)


(* 4 *)

fun dates_in_month(dates : (int * int * int) list, month : int) =
  if null dates
  then []
  else let
    val rest = dates_in_month(tl dates, month)
    val date = hd dates
  in
    if #2 date = month
    then date::rest
    else rest
  end


(* 5 *)

fun dates_in_months(dates : (int * int * int) list, months: int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)


(* 6 *)

fun get_nth(items : 'a list, n : int) =
  if n = 1
  then hd items
  else get_nth(tl items, n - 1)


(* 7 *)

fun date_to_string(y : int, m : int, d : int) : string =
  int_to_month(m) ^ " " ^ Int.toString d ^ ", " ^ Int.toString y


(* 8 *)

fun number_before_reaching_sum(sum : int, ns : int list) =
  if sum <= 0
  then ~1
  else 1 + number_before_reaching_sum(sum - hd ns, tl ns)


(* 9 *)

fun what_month(d : int) =
  1 + number_before_reaching_sum(d, days_in_month)


(* 10 *)

fun month_range(x : int, y : int) =
  if (x > y)
  then []
  else let
    val wm = what_month x
  in
    if (x = y)
    then [wm]
    else wm::month_range(x + 1, y)
  end


(* 11 *)

fun oldest(dates : (int * int * int) list) =
  if null dates
  then NONE
  else let
    val head = hd dates
    val tail = tl dates
    val recur = oldest(tail)
  in
    if isSome recur andalso is_older(valOf recur, head)
    then SOME(valOf recur)
    else SOME(head)
  end


(* 12 *)

fun number_in_months_challenge(months : (int * int * int) list, nums : int list) =
  number_in_months(months, uniq nums)

fun dates_in_months_challenge(dates : (int * int * int) list, months: int list) =
  dates_in_months(dates, uniq months)

(* 13 *)

fun reasonable_date(date : (int * int * int)) =
  let
    val year = #1 date
    val month = #2 date
    val day = #3 date
    val leap_year = year mod 4 = 0
    val days =
      if (leap_year)
      then days_in_month_leap
      else days_in_month
  in
    (year > 0)
    andalso (month > 0) andalso (month <= 12)
    andalso (day > 0) andalso (day <= 31)
    andalso (day <= get_nth(days, month))
  end
