interface intf(input logic clk,rst);
  logic [31:0] paddr;
  logic psel,penable,pwrite;
  logic [31:0] pwdata,prdata;
  logic pready;
  
  clocking drvcb @(posedge clk);
    output paddr,psel,penable,pwrite,pwdata;
    input prdata;
  endclocking
  
  clocking moncb @(posedge clk);
    input paddr,psel,penable,pwrite,pwdata,prdata,pready;
  endclocking

endinterface
