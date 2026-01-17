class apb_sequence extends uvm_sequence #(seq_item);
  `uvm_object_utils(apb_sequence)
  seq_item item;
  function new(string name="apb_sequence");
    super.new(name);
    `uvm_info("seq class","inside constructor",UVM_HIGH);
  endfunction
  
  task body();
    repeat(80) begin
    item=seq_item::type_id::create("item");
    start_item(item);
      assert(item.randomize());
    finish_item(item);
    end
  endtask
endclass
