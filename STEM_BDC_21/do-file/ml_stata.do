global learner "svm"
global y daily_0
global x "daily_1-positive"
gen i=_n
preserve
keep if i<145
drop i
save data_train, replace
restore
preserve
keep if i>144
drop $y
drop i
save data_test, replace
restore
preserve
keep if i>144
keep $y
gen index=_n-1
save test_y, replace
restore
use data_train, clear
r_ml_stata $y $x, mlmodel($learner) in_prediction("in_pred")  cross_validation("CV") out_sample("data_test") out_prediction("out_pred") seed(10) save_graph_cv("graph_cv")

ereturn list
use in_pred, clear
gen id=_n
sort id
tw(line $y id, lc(green)) (line in_pred id, lc(orange)), xtitle("Units' Identifier") legend(order(1 "Actual" 2 "In-sample prediction")) note(LEARNER: $learner) plotregion(style(none)) scheme(s1mono)
use out_pred, clear
merge 1:1 index using "test_y"
tw(line $y index, lc(green)) (line out_sample_pred index, lc(orange)), xtitle("Units' Identifier") legend(order(1 "Actual" 2 "Out-sample prediction")) note(LEARNER: $learner) plotregion(style(none)) scheme(s1mono)
use CV, clear
list in 1/10, table
use out_pred , clear
list, table
