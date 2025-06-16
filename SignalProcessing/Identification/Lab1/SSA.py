import numpy as np
import matplotlib.pyplot as plt

def SSA(x, L):
    N = len(x)
    Y = np.zeros((L,N-L+1))

    for l in range(L):
        Y[l, :] = x[l:N - L + l + 1]

    U, S, Vt = np.linalg.svd(Y)
    V = Vt.T

    PC = np.zeros((L, N - L + 1, L))
    
    for i in range(L):
        PC[:, :, i] = S[i] * np.outer(U[:, i], V[:, i])


    RC = np.zeros((L, N - L + 1, 4))
    RC[:, :, 0] = PC[:, :, 0]
    RC[:, :, 1] = PC[:, :, 1] + PC[:, :, 2]
    RC[:, :, 2] = PC[:, :, 3] + PC[:, :, 4]
    RC[:, :, 3] = np.zeros((L, N - L + 1))

    for i in range(5, L):
        RC[:, :, 3] += PC[:, :, i]

    H = np.zeros((L, N - L + 1, 4))
    for j in range(4):
        H[:, :, j] = np.flip(RC[:, :, j],axis=0)

    ip = np.arange(-L + 1, N - L + 1)

    Sh = np.zeros((N, 4))
    for l in range(4):
        for i in range(len(ip)):
            Sh[i, l] = np.mean(np.diag(H[:, :, l], ip[i]))

    return Sh, Y, RC

# Example usage
N = 1000
t = np.linspace(0, 200, N)
trend = 0.0025 * (t - 100) ** 2
p1 = 20
p2 = 5
periodic1 = 2 * np.sin(2 * np.pi * t / p1)
periodic2 = 0.75 * np.sin(2 * np.pi * t / p2)
noise = 0.75 * (np.random.rand(N) - 0.5)
x = trend + periodic1 + periodic2 + noise

Sh, Y, RC = SSA(x, 70)

plt.plot(t, x, label='Signal', linewidth=1.5)
for i in range(4):
   plt.plot(t, Sh[:, i], label=f'Sh{i+1}')
   plt.xlabel('Time [s]', fontsize=14)
   plt.ylabel('Signal Amplitude', fontsize=14)
   plt.grid(True)
   plt.legend(fontsize=14)
   

