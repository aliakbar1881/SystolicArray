module testbenchv3;
    logic clk = 0;
    logic reset;
    byte A[0:3][0:3];
    byte B[0:3][0:3];
    int R[0:3][0:3];
    
    SystolicArrayV3 sys (.*);
    
    always #5 clk = ~clk;
    
    initial begin
        for(int i=0; i<4; i++) begin
            for(int j=0; j<4; j++) begin
                A[i][j] = (i == j) ? 1 : 0;
                B[i][j] = i + j;
            end
        end
     end
     
     initial begin
        reset = 1;
        @(posedge clk);
        @(posedge clk);
        reset = 0;
        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        
        for(int i=0; i<4; i++) begin
            $display("%d %d %d %d", R[i][0], R[i][1], R[i][2], R[i][3]);
        end
        $finish;
    end
endmodule
