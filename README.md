# verification-of-APB-slave-using-UVM

This project focuses on the functional verification of an AMBA APB (Advanced Peripheral Bus) Slave using the Universal Verification Methodology (UVM). The objective is to validate correct APB protocol behavior for read and write transactions and ensure reliable data transfer between the master and the slave.

The APB slave is verified using a layered UVM testbench architecture consisting of sequence items, sequences, sequencer, driver, monitor, scoreboard, agent, environment, and test. Randomized and directed test scenarios are used to generate APB write and read transactions, ensuring thorough protocol coverage.

The driver converts sequence items into pin-level APB signals (PSEL, PENABLE, PWRITE, PADDR, PWDATA), while the monitor samples bus activity during the valid ACCESS phase (PSEL=1, PENABLE=1, PREADY=1). The scoreboard maintains a reference model to compare expected data against the actual read data (PRDATA), thereby validating data integrity and correct slave operation.

The verification environment also checks:
1. Proper APB state transitions (SETUP → ACCESS)
2. Correct assertion of PREADY
3. Accurate read/write functionality
4. Handling of reset conditions
5. Protocol-compliant timing behavior

This project demonstrates a strong understanding of AMBA APB protocol, SystemVerilog, and UVM-based verification, making it suitable for showcasing skills required for ASIC/SoC verification roles.
 
