class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  virtual intf vif;
  seq_item item;
  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("driver class","inside constructor class",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("driver class","inside build phase",UVM_HIGH);
    if(!(uvm_config_db #(virtual intf)::get(this,"*","vif",vif)))
      begin
      `uvm_error("driver class","failed to get vif from config db");
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("driver class","inside connect phase",UVM_HIGH);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("driver class","inside run phase",UVM_HIGH);
    this.vif.drvcb.psel<=0;
    this.vif.drvcb.penable<=0;
    forever begin
      @(this.vif.drvcb);
       item=seq_item::type_id::create("item");
      seq_item_port.get_next_item(item);
      @(this.vif.drvcb);
      `uvm_info("driver class","GOT TRANSACTION", UVM_HIGH);
      case(item.pwrite)
        seq_item::read: drv_read(item.addr,item.data);
        seq_item::write: drv_write(item.addr,item.data);
      endcase
      seq_item_port.item_done();
    end
  endtask
  virtual task drv_read(input bit [31:0] addr, output logic [31:0] data);
    this.vif.drvcb.paddr<=addr;
    this.vif.drvcb.pwrite<=0;
    this.vif.drvcb.psel<=1;
    @(this.vif.drvcb);
    this.vif.drvcb.penable<=1;
    @(this.vif.drvcb);
    data=this.vif.drvcb.prdata;
    this.vif.drvcb.psel<=0;
    this.vif.drvcb.penable<=0;
  endtask
  
  virtual task drv_write(input bit [31:0] addr, input bit [31:0] data);
    this.vif.drvcb.paddr<=addr;
    this.vif.drvcb.pwdata<=data;
    this.vif.drvcb.pwrite<=1;
    this.vif.drvcb.psel<=1;
    @(this.vif.drvcb);
    this.vif.drvcb.penable<=1;
    @(this.vif.drvcb);
    this.vif.drvcb.psel<=0;
    this.vif.drvcb.penable<=0;
  endtask
    
endclass
