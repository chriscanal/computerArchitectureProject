To test out our processor, run simulation with the file "Processor_tb.v".  
Run time should be set to 149.5us because run time is 149us, and the first 
posedge of the clock occurs at 0.5us.

To check the contents of the register file, look at the transcript window 
after the simulation has been run.  The contents are printed out every clock 
cycle, with the right side of the array holding register 0.

Also, note that we set all of our registers to 0 using an initial statement 
in Reg_File.v.
