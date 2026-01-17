class enivornment extends uvm_env;
  `uvm_component_utils(enivornment)
  agent agen;
  scoreboard scb;
  function new(string name="enivornment",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("enivornment class","inside constructor class",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("enivornment class","inside build phase",UVM_HIGH);
    agen=agent::type_id::create("agen",this);
    scb=scoreboard::type_id::create("scb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("enivornment class","inside connect phase",UVM_HIGH);
    agen.mon.monitor_port.connect(scb.scoreboard_port);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("enivornment class","inside run phase",UVM_HIGH);
  endtask
endclass
