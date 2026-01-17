module apb_slave(input logic clk,rst,
                 input logic [31:0] paddr,
                input logic psel,penable,pwrite,
                 input logic [31:0] pwdata,
                output logic pready,
                 output logic [31:0] prdata);
  
  logic [31:0] mem [0:255];
  logic [1:0] state;
  const logic [1:0] setup=0;
  const logic [1:0] wen=1;
  const logic [1:0] ren=2;
  
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          pready<=1;
          prdata=0;
          state<=0;
          for(int i=0;i<256;i++)
            mem[i]=0;
        end
      else 
        begin
          case(state)
            setup: begin
              prdata<=0;
              if(psel && !penable)
                begin
                  if(pwrite)
                    begin
                      state<=wen;
                    end
                  else
                    begin
                      state<=wen;
                      prdata<=mem[paddr];
                    end
                end
            end
            
            wen: begin
              if(psel && penable && pwrite)
                begin
                  mem[paddr]<=pwdata;
                end
              state<=setup;
            end
            
            ren: begin
              state<=setup;
            end
          endcase
        end
    end
endmodule
