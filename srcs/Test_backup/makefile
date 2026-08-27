all:
	vlog -sv +acc +cover +fcover -l simulation.log top.sv
	
regression:
	vsim -vopt work.tb -voptargs=+acc=npr -assertdebug -l regressions_test.log -coverage +UVM_TESTNAME=regression_test -c -wlf dump.wlf -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vsim -c -do "wlf2vcd dump.wlf -o dump.vcd;exit"
	vcover report -html coverage.ucdb -htmldir covReport -details 
