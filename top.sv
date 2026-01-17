`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"

module top;
  logic clk,rst;
  intf intff(clk,rst);
  apb_slave  dut(.clk(intff.clk),.rst(intff.rst),.paddr(intff.paddr),.psel(intff.psel),.penable(intff.penable),.pwrite(intff.pwrite),.pwdata(intff.pwdata),.prdata(intff.prdata),.pready(intff.pready));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=0;
    repeat(1) @(posedge clk);
     rst=1;
  end
  
  initial begin
    uvm_config_db #(virtual intf)::set(null,"*","vif",intff);
    run_test("test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  initial begin
    #5000;
    $display("sorry! ran out of clock");
    $finish;
  end
endmodule
