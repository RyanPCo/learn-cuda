#include <iostream>
#include <vector>
#include <cuda_runtime.h>

using namespace std;

__global__ void sumArrays(int *A, int *B, long long *partialSum, int size) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
        if (idx < size) {
            partialSum[idx] = A[idx] + B[idx];
        }
}

__global__ void reduce(long long *partialSum, int size) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    int stride = 1;

    while (stride < size) {
        if (idx < size - stride) {
            partialSum[idx] += partialSum[idx + stride];
        }
        __syncthreads();
        stride *= 2;
    }
}

int main () {
    cout << "Program Start" << endl;
    long long size = 1000000000;
    int sum = 0;

    int blockSize = 256;
    int numBlocks = (size + blockSize - 1) / blockSize;

    vector<int> A(size), B(size);
    vector <long long> partialSum(size);

    for (int i = 0; i < size; i++) {
        A[i] = i;
        B[i] = B.size() - i;
    }

    int *d_A, *d_B;
    long long *d_partialSum;
    cudaMalloc(&d_A, size * sizeof(int));
    cudaMalloc(&d_B, size * sizeof(int));
    cudaMalloc(&d_partialSum, numBlocks * sizeof(long long));

    cudaMemcpy(d_A, A.data(), size * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B.data(), size * sizeof(int), cudaMemcpyHostToDevice);

    cout << "Copy Memory" << endl;

    sumArrays<<<numBlocks, blockSize>>>(d_A, d_B, d_partialSum, size);

    cout << "Sum" << endl;

    reduce<<<numBlocks, blockSize>>>(d_partialSum, size);

    cout << "Reduce" << endl;

    cudaMemcpy(&sum, d_partialSum, sizeof(long long), cudaMemcpyDeviceToHost);

    cout << sum << endl;

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_partialSum);

    return 0;
}
