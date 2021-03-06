(* Dan Grossman, CSE341 Spring 2013, HW3 Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1 *) (*string list -> string list *)
fun only_capitals(xs) =  List.filter (fn x => Char.isUpper(String.sub(x,0))) xs

(* 2 *) (*string list -> string*)
fun longest_string1(xs) =
  List.foldl ((fn (x,y) => if String.size x > String.size y then x else y)) "" xs

(* 3 *) (*string list -> string *)
fun longest_string2(xs) =
  List.foldl ((fn (x,y) => if String.size y > String.size x then y else x)) "" xs
(* 4 *) (*(int * int -> bool) -> string list -> string*)
fun longest_string_helper f xs =
  List.foldl (fn (x,y) => if f(String.size(x),String.size(y))then x else y) "" xs

val longest_string3 = longest_string_helper (fn(x,y) => x > y) 

val longest_string4 = longest_string_helper (fn(x,y) => x >= y) 

(* 5 *)
					   
(*fun longest_capitalized xs =
  List.foldl ((fn (x,y) => if String.size x > String.size y andalso Char.isUpper(String.sub(x,0)) then x else y)) "" xs*)

val longest_capitalized = longest_string3 o only_capitals 

val rev_string = implode o rev o explode


(* Question 2*)

(* 7 *) 

fun first_answer f x =
  case x of 
      [] => raise NoAnswer
    | head::tail => case f head of 
			NONE => first_answer f tail
		      | SOME v => v 

(* 8 *)
fun all_answers f optlist =
  let fun aux(lst,acc) =
	     case lst of 
		 [] => SOME acc
	       | x::xs  => case f x of 
			       NONE => NONE 
			     | SOME v => aux(xs, acc @ v)
  in
      aux(optlist,[])
  end

(* 9 *)

val count_wildcards = g (fn () => 1)(fn str => 0)

val count_wild_and_variable_lengths = g (fn() => 1) String.size

fun count_some_var (str, pattern) =
  g(fn () => 0) (fn s => if s = str then 1 else 0) pattern


(* challenge *)
fun lenient(t1, t2) =
  if t1 = t2 then t1 else 
  case (t1,t2) of 
      (_, Anything) => t1
    | (Anything, _) => t2
    | (TupleT ps1, TupleT ps2) => if List.length ps1 = List.length ps2
				  then TupleT(List.map lenient(ListPair.zip(ps1,ps2)))
				  else raise NoAnswer
    | (_,_) => raise NoAnswer


