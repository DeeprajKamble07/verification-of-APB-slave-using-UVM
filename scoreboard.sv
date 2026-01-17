class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  seq_item queue[$];
  bit [31:0] sc_mem [0:255];
  uvm_analysis_imp #(seq_item,scoreboard) scoreboard_port;
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
    scoreboard_port=new("scoreboard_port",this);
    `uvm_info("scoreboard class","inside constructor class",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("scoreboard class","inside build phase",UVM_HIGH);
    foreach(sc_mem[i]) sc_mem[i]=0;
  endfunction
  
  function void write(seq_item item);
    queue.push_back(item);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("scoreboard class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("scoreboard class","inside run phase",UVM_HIGH);
    forever begin
      seq_item ex_item;
      wait(queue.size()>0);
      ex_item=queue.pop_front();
      
      if(ex_item.pwrite == seq_item:: write)
        begin
          sc_mem[ex_item.addr]=ex_item.data;
          `uvm_info("APB_SCOREBOARD",$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
          `uvm_info("",$sformatf("Addr: %0h Data: %0h",ex_item.addr,ex_item.data),UVM_LOW)
        end
      else if(ex_item.pwrite == seq_item:: read)
        begin
          if(sc_mem[ex_item.addr]==ex_item.data)
            begin
              `uvm_info("APB_SCOREBOARD",$sformatf("------ :: READ DATA MATCH       :: ------"),UVM_LOW)
              `uvm_info("",$sformatf("Addr: %0h Expected Data: %0h Actual Data: %0h",ex_item.addr,sc_mem[ex_item.addr],ex_item.data),UVM_LOW)
            end
          else
            begin
              `uvm_error("APB_SCOREBOARD","------ :: READ DATA MisMatch :: ------")
              `uvm_info("",$sformatf("Addr: %0h Expected Data: %0h Actual Data: %0h",ex_item.addr,sc_mem[ex_item.addr],ex_item.data),UVM_LOW)
            end
        end
    end
  endtask
endclass
