class PE;
    byte areg;
    byte breg;
    int  accreg;
    int  lastacc; 
    
    function new ();
        this.lastacc = 0;
        this.areg = 0;
        this.breg = 0;
        this.accreg = 0;
    endfunction
    
    function void onestep (byte ain, byte bin);
        this.lastacc = this.accreg;
        this.accreg = this.lastacc + this.areg * this.breg;
        this.areg = ain;
        this.breg = bin;
    endfunction

    function void reset ();
        this.areg = 0;
        this.breg = 0;
        this.accreg = 0;
    endfunction

    function byte getareg ();
        return this.areg;
    endfunction

    function byte getbreg ();
        return this.breg;
    endfunction

    function int getacc();
        return this.accreg;
    endfunction
endclass

module SystolicArrayV1(
    input byte A [0:3][0:3],
    input byte B [0:3][0:3],
    output int R [0:3][0:3]
);
    PE pe1_1, pe1_2, pe1_3, pe1_4, pe2_1, pe2_2, pe2_3, pe2_4, 
       pe3_1, pe3_2, pe3_3, pe3_4, pe4_1, pe4_2, pe4_3, pe4_4;
    byte a11, b11, a12, b12, a13, b13, a14, b14, 
         a21, b21, a22, b22, a23, b23, a24, b24,
         a31, b31, a32, b32, a33, b33, a34, b34,
         a41, b41, a42, b42, a43, b43, a44, b44;
    logic clk = 0;

    always @(posedge clk) begin
        pe1_1 = new();
        pe1_2 = new();
        pe1_3 = new();
        pe1_4 = new();
        pe2_1 = new();
        pe2_2 = new();
        pe2_3 = new();
        pe2_4 = new();
        pe3_1 = new();
        pe3_2 = new();
        pe3_3 = new();
        pe3_4 = new();
        pe4_1 = new();
        pe4_2 = new();
        pe4_3 = new();
        pe4_4 = new();

        // cycle 1
        pe1_1.onestep(A[0][0], B[0][0]);

        // cycle 2
        a11 = pe1_1.getareg();
        b11 = pe1_1.getbreg();
        pe1_1.onestep(A[0][1], B[1][0]);
        pe1_2.onestep(a11, B[0][1]);
        pe2_1.onestep(A[1][0], b11);

        // cycle 3
        a11 = pe1_1.getareg();
        b11 = pe1_1.getbreg();
        a12 = pe1_2.getareg();
        b12 = pe1_2.getbreg();
        a21 = pe2_1.getareg();
        b21 = pe2_1.getbreg();
        pe1_1.onestep(A[0][2], B[2][0]);
        pe1_2.onestep(a11, B[1][1]);
        pe1_3.onestep(a12, B[0][2]);
        pe2_1.onestep(A[1][1], b11);
        pe2_2.onestep(a21, b12);
        pe3_1.onestep(A[2][0], b21);

        // cycle 4
        a11 = pe1_1.getareg();
        b11 = pe1_1.getbreg();
        a12 = pe1_2.getareg(); 
        b12 = pe1_2.getbreg();
        a13 = pe1_3.getareg();
        b13 = pe1_3.getbreg();
        a21 = pe2_1.getareg();
        b21 = pe2_1.getbreg();
        a22 = pe2_2.getareg();
        b22 = pe2_2.getbreg();
        a31 = pe3_1.getareg();
        b31 = pe3_1.getbreg();
        pe1_1.onestep(A[0][3], B[3][0]);
        pe1_2.onestep(a11, B[2][1]);
        pe1_3.onestep(a12, B[1][2]);
        pe1_4.onestep(a13, B[0][3]);
        pe2_1.onestep(A[1][2], b11);
        pe2_2.onestep(a21, b12);
        pe2_3.onestep(a22, b13);
        pe3_1.onestep(A[2][1], b21);
        pe3_2.onestep(a31, b22);
        pe4_1.onestep(A[3][0], b31);

        // cycle 5
        a11 = pe1_1.getareg(); 
        b11 = pe1_1.getbreg();
        a12 = pe1_2.getareg(); 
        b12 = pe1_2.getbreg();
        a13 = pe1_3.getareg(); 
        b13 = pe1_3.getbreg();
        a21 = pe2_1.getareg(); 
        b21 = pe2_1.getbreg();
        a22 = pe2_2.getareg(); 
        b22 = pe2_2.getbreg();
        a23 = pe2_3.getareg();
        b23 = pe2_3.getbreg();
        a31 = pe3_1.getareg(); 
        b31 = pe3_1.getbreg();
        a32 = pe3_2.getareg(); 
        b32 = pe3_2.getbreg();
        a41 = pe4_1.getareg(); 
        b41 = pe4_1.getbreg();
        pe1_2.onestep(a11, B[3][1]);
        pe1_3.onestep(a12, B[2][2]);
        pe1_4.onestep(a13, B[1][3]);
        pe2_1.onestep(A[1][3], b11);
        pe2_2.onestep(a21, b12);
        pe2_3.onestep(a22, b13);
        pe2_4.onestep(a23, b14);
        pe3_1.onestep(A[2][2], b21);
        pe3_2.onestep(a31, b22);
        pe3_3.onestep(a32, b23);
        pe4_1.onestep(A[3][1], b31);
        pe4_2.onestep(a41, b32);

        // cycle 6
        a12 = pe1_2.getareg(); 
        b12 = pe1_2.getbreg();
        a13 = pe1_3.getareg(); 
        b13 = pe1_3.getbreg();
        a22 = pe2_2.getareg(); 
        b22 = pe2_2.getbreg();
        a23 = pe2_3.getareg(); 
        b23 = pe2_3.getbreg();
        a31 = pe3_1.getareg(); 
        b31 = pe3_1.getbreg();
        a32 = pe3_2.getareg(); 
        b32 = pe3_2.getbreg();
        a33 = pe3_3.getareg(); 
        b33 = pe3_3.getbreg();
        a41 = pe4_1.getareg(); 
        b41 = pe4_1.getbreg();
        a42 = pe4_2.getareg(); 
        b42 = pe4_2.getbreg();
        b14 = pe1_4.getbreg();
        b24 = pe2_4.getbreg();
        b34 = pe3_4.getbreg();
        pe1_3.onestep(a12, B[3][2]);
        pe1_4.onestep(a13, B[2][3]);
        pe2_3.onestep(a22, b13);
        pe2_4.onestep(a23, b14);
        pe3_2.onestep(a31, b22);
        pe3_3.onestep(a32, b23);
        pe3_4.onestep(a33, b24);
        pe4_2.onestep(a41, b32);
        pe4_3.onestep(a42, b33);

        // cycle 7
        a13 = pe1_3.getareg(); 
        b13 = pe1_3.getbreg();
        a23 = pe2_3.getareg(); 
        b23 = pe2_3.getbreg();
        a33 = pe3_3.getareg(); 
        b33 = pe3_3.getbreg();
        a42 = pe4_2.getareg(); 
        b42 = pe4_2.getbreg();
        a43 = pe4_3.getareg(); 
        b43 = pe4_3.getbreg();
        b14 = pe1_4.getbreg();
        b24 = pe2_4.getbreg();
        b34 = pe3_4.getbreg();
        pe1_4.onestep(a13, B[3][3]);
        pe2_4.onestep(a23, b14);
        pe3_4.onestep(a33, b24);
        pe4_3.onestep(a42, b33);
        pe4_4.onestep(a43, b34);

        // cycle 8
        a43 = pe4_3.getareg(); 
        b43 = pe4_3.getbreg();
        b34 = pe3_4.getbreg();
        pe4_4.onestep(a43, b34);


        pe1_1.onestep(0, 0);
        pe1_2.onestep(0, 0);
        pe1_3.onestep(0, 0);
        pe1_4.onestep(0, 0);
        pe2_1.onestep(0, 0);
        pe2_2.onestep(0, 0);
        pe2_3.onestep(0, 0);
        pe2_4.onestep(0, 0);
        pe3_1.onestep(0, 0);
        pe3_2.onestep(0, 0);
        pe3_3.onestep(0, 0);
        pe3_4.onestep(0, 0);
        pe4_1.onestep(0, 0);
        pe4_2.onestep(0, 0);
        pe4_3.onestep(0, 0);
        pe4_4.onestep(0, 0);


        R[0][0] = pe1_1.getacc(); 
        R[0][1] = pe1_2.getacc(); 
        R[0][2] = pe1_3.getacc(); 
        R[0][3] = pe1_4.getacc();
        R[1][0] = pe2_1.getacc(); 
        R[1][1] = pe2_2.getacc(); 
        R[1][2] = pe2_3.getacc(); 
        R[1][3] = pe2_4.getacc();
        R[2][0] = pe3_1.getacc(); 
        R[2][1] = pe3_2.getacc(); 
        R[2][2] = pe3_3.getacc(); 
        R[2][3] = pe3_4.getacc();
        R[3][0] = pe4_1.getacc(); 
        R[3][1] = pe4_2.getacc(); 
        R[3][2] = pe4_3.getacc(); 
        R[3][3] = pe4_4.getacc();
    end
endmodule