class agent extends uvm_agent;
  `uvm_component_utils(agent)
  driver drv;
  monitor mon;
  sequencer sqnr;
  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("agent class","inside constructor class",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("agent class","inside build phase",UVM_HIGH);
    drv=driver::type_id::create("drv",this);
    mon=monitor::type_id::create("mon",this);
    sqnr=sequencer::type_id::create("sqnr",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("agent class","inside connect phase",UVM_HIGH);
    drv.seq_item_port.connect(sqnr.seq_item_export);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("agent class","inside run phase",UVM_HIGH);
  endtask
endclass
