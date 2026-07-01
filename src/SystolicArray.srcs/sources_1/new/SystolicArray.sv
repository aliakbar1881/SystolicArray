module SystolicArrayV2 (
    input  logic clk,
    input  logic reset,

    input  byte a_in [0:3], 
    input  byte b_in [0:3],
    output int  R    [0:3][0:3]
);

    byte a_pipe [0:3][0:4];
    byte b_pipe [0:4][0:3];
    int  acc    [0:3][0:3];

    genvar i, j;
    generate
        for (i = 0; i < 4; i++) begin
            assign a_pipe[i][0] = a_in[i];
            assign b_pipe[0][i] = b_in[i];
        end
    endgenerate

    always_ff @(posedge clk) begin
        if (reset) begin
            for (int r = 0; r < 4; r++) begin
                for (int c = 0; c < 4; c++) begin
                    acc[r][c] <= 0;
                    a_pipe[r][c+1] <= 0;
                    b_pipe[r+1][c] <= 0;
                end
            end
        end else begin
            for (int r = 0; r < 4; r++) begin
                for (int c = 0; c < 4; c++) begin

                    acc[r][c] <= acc[r][c] + (a_pipe[r][c] * b_pipe[r][c]);
                    
                    a_pipe[r][c+1] <= a_pipe[r][c];
                    b_pipe[r+1][c] <= b_pipe[r][c];
                end
            end
        end
    end

    assign R = acc;

endmodule