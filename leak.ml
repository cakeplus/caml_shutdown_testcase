
let adder a b =
  a + b

let num =
  Num.add_num (Int 4) (Int 6)

(* A finalisable custom block *)
let arr =
  Bigarray.(Genarray.create float64 c_layout [| 5; 5; 5; 5 |])

(* Additional finaliser *)
let _ =
  arr |> Gc.finalise (fun v -> ())

(* Registering a named value *)
let _ =
  Callback.register "adder" adder
