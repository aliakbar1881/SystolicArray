module SystolicArrayV3(
    input byte A [0:3][0:3],
    input byte B [0:3][0:3],
    input logic clk,
    input logic reset,
    output int R [0:3][0:3]
);

    byte apipe [0:3][0:4];
    byte bpipe [0:4][0:3];
    int result [0:3][0:3];
    int cycle;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            cycle <= 0;
            for (int i=0; i<4; i++) begin
                for (int j=0; j<4; j++) begin
                    result[i][j] <= 0;
                    apipe[i][j] <= 0;
                    bpipe[i][j] <= 0;
                end
                apipe[i][4] <= 0;
                bpipe[4][i] <= 0;
            end
        end else begin
            for (int i = 0; i < 4; i++) begin
                if (cycle >= i && (cycle - i) < 4)
                    apipe[i][0] <= A[i][cycle - i];
                else
                    apipe[i][0] <= 0;
                
                if (cycle >= i && (cycle - i) < 4)
                    bpipe[0][i] <= B[cycle - i][i];
                else
                    bpipe[0][i] <= 0;
            end
            
            for (int i = 0; i < 4; i++) begin
                for (int j = 0; j < 4; j++) begin
                    result[i][j] <= result[i][j] + (apipe[i][j] * bpipe[i][j]);
                    apipe[i][j+1] <= apipe[i][j];
                    bpipe[i+1][j] <= bpipe[i][j];
                end
            end
            cycle <= cycle + 1;
        end
        assign R = result;
    end

endmodule
