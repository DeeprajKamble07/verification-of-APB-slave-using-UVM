class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item);
  typedef enum{read,write} kind_e;
  rand kind_e pwrite;
  rand bit [31:0] addr;
  rand bit [31:0] data;
  
  function new(string name="seq_item");
    super.new(name);
    `uvm_info("seq_item class","inside constructor",UVM_HIGH);
  endfunction
  
  constraint c1{addr[31:0]>=32'd255; addr[31:0] <32'd256;};
  constraint c2{data[31:0]>=32'd0; data[31:0] <32'd256;};
endclass
