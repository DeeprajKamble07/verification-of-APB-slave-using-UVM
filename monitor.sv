class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  virtual intf vif;
  seq_item item;
  uvm_analysis_port #(seq_item) monitor_port;
  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
    monitor_port=new("monitor_port",this);
    `uvm_info("monitor class","inside constructor class",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("monitor class","inside build phase",UVM_HIGH);
    if(!(uvm_config_db #(virtual intf)::get(this,"*","vif",vif)))
      begin
      `uvm_error("driver class","failed to get vif from config db");
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("monitor class","inside connect phase",UVM_HIGH);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("monitor class","inside run phase",UVM_HIGH);
    forever begin
      do begin
        @(this.vif.moncb);
      end
      while(this.vif.moncb.psel != 1'b1 || this.vif.moncb.penable !=1'b0);
      item=seq_item::type_id::create("item");
      item.pwrite=(this.vif.moncb.pwrite)? seq_item::write: seq_item::read;
      item.addr=this.vif.moncb.paddr;
      @(this.vif.moncb)
      if(this.vif.moncb.penable !=1)
        begin
          `uvm_info("APB","APB protocol violation: setup cycle not followed by enable cycle",UVM_HIGH);
        end
      
      if(item.write==seq_item::read)
        begin
          item.data=this.vif.moncb.prdata;
        end
      else if(item.write==seq_item::write)
        begin
          item.data=this.vif.moncb.pwdata;
        end
      `uvm_info("APB","GOT TRANSACTION",UVM_HIGH);
      monitor_port.write(item);
    end
  endtask
endclass
