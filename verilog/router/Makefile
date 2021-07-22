run: clean
	iverilog dut.v router.v -o router.out
	./router.out
	gtkwave router.vcd &

clean:
	rm -rf router.out router.vcd 
