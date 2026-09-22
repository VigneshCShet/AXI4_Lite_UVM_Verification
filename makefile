all:
	vlog -sv +acc +cover +fcover -l simulation.log srcs/Design/design.sv srcs/Testbench/top.sv
	
regression:
	vsim -vopt work.tb -voptargs=+acc=npr -assertdebug -l regressions_test.log -coverage +UVM_TESTNAME=regression_test -c -wlf dump.wlf -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vsim -c -do "wlf2vcd dump.wlf -o dump.vcd;exit"
	vcover report -html coverage.ucdb -htmldir covReport -details 
	
error:
	vsim -vopt work.tb -voptargs=+acc=npr -assertdebug -l error_test.log -coverage +UVM_TESTNAME=error_test -c -wlf dump.wlf -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vsim -c -do "wlf2vcd dump.wlf -o dump.vcd;exit"
	vcover report -html coverage.ucdb -htmldir covReport -details
	
sanity:
	vsim -vopt work.tb -voptargs=+acc=npr -assertdebug -l sanity_test.log -coverage +UVM_TESTNAME=sanity_test -c -wlf dump.wlf -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vsim -c -do "wlf2vcd dump.wlf -o dump.vcd;exit"
	vcover report -html coverage.ucdb -htmldir covReport -details
	
corner:
	vsim -vopt work.tb -voptargs=+acc=npr -assertdebug -l corner_test.log -coverage +UVM_TESTNAME=corner_test -c -wlf dump.wlf -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vsim -c -do "wlf2vcd dump.wlf -o dump.vcd;exit"
	vcover report -html coverage.ucdb -htmldir covReport -details
