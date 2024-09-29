import excel "https://github.com/solomon-idan/Oswego/blob/main/tabula-xoswego.401-303.student.csv") firstrow clear

rename A id

label define sex 1 "Male" 2 "Female"

label define yesno 0 "No" 1 "Yes"

label values sex sex

label values ill yesno
label values bakedham yesno
label values spich yesno
label values mashedpotato yesno
label values cabbage_salad yesno
label values jello yesno
label values rolls yesno
label values brownbread yesno
label values milk yesno
label values coffee yesno
label values water yesno
label values cakes yesno
label values vanilla yesno
label values chocolate yesno
label values fruit yesno


gen dateofmeal= date("18 april 1940","DMY"),before(timeofmeal)
format dateofmeal %d

gen double dtmeal= dhms(dateofmeal,hh(timeofmeal),mm(timeofmeal),ss(timeofmeal)),before(ill)
format dtmeal %tc

gen double dtonset= dhms(dateofonset,hh(timeofonset),mm(timeofonset),ss(timeofonset)),before(bakedham)
format dtonset %tc

gen double incuperiod= dtonset-dtmeal,before(bakedham)
format incuperiod %tcHH:MM:SS

egen incumean=mean(incuperiod)
format incumean %tcHH:MM:SS

egen incumedian=median(incuperiod)
format incumedian %tcHH:MM:SS
list incumedian

*range
egen incumin=min(incuperiod)
format incumin %tcHH:MM:SS
list incumin

egen incumax=max(incuperiod)
format incumax %tcHH:MM:SS
list incumax

tab dtonset ill

drop if ill==0

**EPICURVE
histogram dtonset, discrete frequency fcolor(cranberry)lcolor(none) ytitle(CASE COUNT) xtitle(TIME OF ONSET) xlabel(#6, labels labsize(small) angle(vertical) format(%tcMon_dd,_CCYY_HH:MM) ticks) xmtick(##10) title(EPICURVE OF GASTRO-INTESTINAL ILLNESS OUTBREK IN OSWEGO, size(medsmall) color(black)) scheme(s2mono)


use "D:\Academics\sem2\field epidemiology\assignment\oswego_cleaned.dta", clear  

**ATTACK RATES
cs bakedham ill
cs spich ill
cs mashedpotato ill
cs cabbage_salad ill
cs jello ill
cs brownbread ill
cs milk ill
cs coffee ill
cs water ill
cs cakes ill
cs vanilla ill
cs chocolate ill
cs fruit ill


**GRAPH OF INCUBATION PERIOD
histogram incuperiod, discrete frequency fcolor(cranberry) lcolor(none) ytitle(CASE COUNT) xtitle(OCCUBATION PERIOD) xlabel(#6, labels labsize(small) angle(horizontal) format(%tcHH:MM) ticks) xmtick(##10) title(HISTOGRAM OF INCUBATION PERIOD FOR GASTRO-INTESTINAL ILLNESS OUTBREK IN OSWEGO, size(medsmall) color(black)) scheme(s2mono)






