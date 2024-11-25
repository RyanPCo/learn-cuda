#include <iostream>
#include <vector>

using namespace std;

int main() {
    int rowsA = 1000, colsA = 1200;
    int rowsB = 1200, colsB = 900;

    vector<vector<int>> A(rowsA, vector<int>(colsA));
    vector<vector<int>> B(rowsB, vector<int>(colsB));
    vector<vector<int>> C(rowsA, vector<int>(colsB, 0)); // Resultant matrix

    // Initializing and printing matrix A
    cout << "Matrix A:" << endl;
    for (int i = 0; i < rowsA; i++) {
        for (int j = 0; j < colsA; j++) {
            A[i][j] = i + j;
            //cout << A[i][j] << " ";
        }
        //cout << "\n";
    }

    cout << "\nMatrix B:" << endl;
    // Initializing and printing matrix B
    for (int i = 0; i < rowsB; i++) {
        for (int j = 0; j < colsB; j++) {
            B[i][j] = i - j;
            //cout << B[i][j] << " ";
        }
        //cout << "\n";
    }

    //cout << "\n";

    // Matrix Multiplication Logic
    for (int i = 0; i < rowsA; i++) {         // Loop through rows of A
        for (int j = 0; j < colsB; j++) {     // Loop through columns of B
            for (int k = 0; k < colsA; k++) { // Loop through columns of A / rows of B
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    // Printing the resultant matrix C
    cout << "Matrix C (A * B):" << endl;
    for (int i = 0; i < rowsA; i++) {
        for (int j = 0; j < colsB; j++) {
            //cout << C[i][j] << " ";
        }
        //cout << "\n";
    }

    return 0;
}
