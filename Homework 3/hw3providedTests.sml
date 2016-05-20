(*tests for homeowrk3 *)

val stringlist1 = ["Hello","Jag","Hopppas","Detta","inte","Fungerar","fungerar"];
val stringlist2 = ["please","Please","Har","En","inte","Bra","Dag"];
val nullstring = [];

val test1 = only_capitals(stringlist1);
val test2 = only_capitals(stringlist2);

val longest11 = longest_string1(stringlist1);
val longest12 = longest_string1(stringlist2);
val longest13 = longest_string1(nullstring);

val longest21 = longest_string2(stringlist1);
val longest22 = longest_string2(stringlist2);
val longest23 = longest_string2(nullstring);

val longestcurry1 = longest_string3(stringlist1);
val longestcurry2 = longest_string3(stringlist2);
val longestcurry3 = longest_string3(nullstring);

val longestcurry21 = longest_string4(stringlist1);
val longestcurry22 = longest_string4(stringlist2);
val longestcurry23 = longest_string4(nullstring);

val longestcap = longest_capitalized(stringlist1);
val longestcap = longest_capitalized(stringlist2);
val longestcap = longest_capitalized(nullstring);

val palindrome = rev_string("palindrome");
val malayalam = rev_string("malayalam");

val a = SOME 3

val letsee = first_answer(fn x => if x > 7 then SOME x else NONE) [1,2,3,4,5,6,7,8];
val letsee2 = all_answers(fn x => if x > 0 then SOME [x] else NONE) [1,2,3,4,5,6,7,8];
