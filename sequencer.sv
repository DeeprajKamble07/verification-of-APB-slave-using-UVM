class sequencer extends uvm_sequencer #(seq_item);
  `uvm_component_utils(sequencer)
  function new(string name="sequencer",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("sequencer class","inside constructor class",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("sequencer class","inside build phase",UVM_HIGH);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("sequencer class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("sequencer class","inside run phase",UVM_HIGH);
  endtask
endclass
