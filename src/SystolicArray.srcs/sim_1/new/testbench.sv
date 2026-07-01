module testbench;
    parameter N = 4;
    logic clk = 0;
    logic reset;
    
    byte A_mat [0:N-1][0:N-1];
    byte B_mat [0:N-1][0:N-1];
    
    byte a_in [0:N-1];
    byte b_in [0:N-1];
    int  R [0:N-1][0:N-1];
    
    int b_row;

    systolic_array dut (.*);

    always #5 clk = ~clk;

    initial begin
        for (int i = 0; i < N; i++) begin
            for (int j = 0; j < N; j++) begin
                A_mat[i][j] = i + j;
                B_mat[i][j] = (i == j) ? 1 : 0;
                end
        end
        
        reset = 1;
        a_in = '{default:0};
        b_in = '{default:0};
        @(posedge clk);
        #1 reset = 0;

        for (int t = 0; t < 3*N; t++) begin
            for (int i = 0; i < N; i++) begin
                int a_col = t - i;
                if (a_col >= 0 && a_col < N)
                    a_in[i] = A_mat[i][a_col];
                else                         
                    a_in[i] = 0;
                $display("\n Result a_in:");
                for (int i = 0; i < N; i++) begin
                    for (int j = 0; j < N; j++) $write("%4d ", a_in[i][j]);
                        $display("");
                end


                b_row = t - i;
                if (b_row >= 0 && b_row < N)
                    b_in[i] = B_mat[b_row][i];
                else
                    b_in[i] = 0;
                $display("\n Result b_in:");
                for (int i = 0; i < N; i++) begin
                    for (int j = 0; j < N; j++) $write("%4d ", b_in[i][j]);
                        $display("");
                end
            end
            @(posedge clk);
            $display("\n Result R:");
            for (int i = 0; i < N; i++) begin
                for (int j = 0; j < N; j++) $write("%4d ", R[i][j]);
                    $display("");
            end
        end
        
        $display("\n Result R (should be same as A):");
        for (int i = 0; i < N; i++) begin
            for (int j = 0; j < N; j++) $write("%4d ", R[i][j]);
            $display("");
        end
        $finish;
    end
endmodule
