efgh:
	@rm -rf *.vvp *.vcd
	@iverilog -g2005-sv -I./ -s tb -Defgh -o efgh.vvp efgh_tb.v hashers.v
	@vvp -n efgh.vvp -lxt2