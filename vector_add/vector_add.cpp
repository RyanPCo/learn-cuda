#include <iostream>
#include <vector>

using namespace std;

int main() {
    long long size = 1000000;
    long long sum = 0;
    
    vector<int> A(size);
    vector<int> B(size);

    for (int i = 0; i < size; i++) {
        A[i] = i;
        B[i] = size - i;
        sum = sum + A[i] + B[i];
    }

    cout << sum;

    return 0;
}
