import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

def pink_noise(num_samples):
    # Define the number of taps for the filter
    num_taps = 16

    # Initialize a 2D array to hold the noise samples
    noise = np.zeros((num_taps, num_samples))

    # Fill the array with random numbers
    noise[0, :] = np.random.normal(0, 1, size=num_samples)

    # Generate pink noise by iteratively adding filtered white noise
    for i in range(1, num_taps):
        b = np.random.normal(0, 1, size=num_samples)
        b_filt = np.convolve(b, np.ones(i) / i, mode='same')
        noise[i, :] = b_filt

    # Sum all rows to get the pink noise
    pink = np.sum(noise, axis=0)

    # Normalize the pink noise to have unit standard deviation
    pink /= np.std(pink)

    return pink


def DFA(t, x1, n):
    """
    Perform Detrended Fluctuation Analysis (DFA) on a time series.

    Parameters:
        t (array-like): Time values.
        x1 (array-like): Time series data.
        n (array-like): Array of segment lengths.

    Returns:
        P (float): Scaling exponent.
        r (array-like): Logarithm of segment lengths.
        Fr (array-like): Logarithm of fluctuation function.
        Yr (array-like): Fitted line.
    """
    L = len(x1)                          # Length of time series
    x1 = x1 - np.mean(x1)                # Remove mean from time series
    y1 = np.cumsum(x1)                   # Cumulative sum of the demeaned time series

    Fn = np.zeros(len(n))                # Initialize array for fluctuation function

    # Loop over segment lengths
    for si in range(len(n)):
        H = np.zeros((L // n[si], n[si]))  # Initialize array for segments
        T = np.zeros((L // n[si], n[si]))  # Initialize array for corresponding time values
        k = 0
        j = 0

        # Divide time series into segments of specified length
        for i in range(L):
            k += 1
            H[j, k - 1] = y1[i]
            T[j, k - 1] = t[i]

            if k == n[si]:
                j += 1
                k = 0

        # Fit a linear polynomial to each segment
        P = np.array([np.polyfit(T[i, :], H[i, :], 1) for i in range(H.shape[0])])

        # Compute the fitted values for each segment
        HR = np.array([np.polyval(P[i, :], T[i, :]) for i in range(H.shape[0])])

        # Compute the root mean square fluctuation
        Fn[si] = np.sqrt(np.mean((H - HR)**2))

    r = np.log(n)                        # Logarithm of segment lengths
    Fr = np.log(Fn)                      # Logarithm of fluctuation function

    # Fit a linear polynomial to the log-log plot of segment lengths versus fluctuation function
    Pf = np.polyfit(r, Fr, 1)
    Yr = np.polyval(Pf, r)               # Compute the fitted line
    P = Pf[0]                            # Extract the scaling exponent

    return P, r, Fr, Yr


# Example usage
df = pd.read_excel("Pink_noise.xlsx", header=None)
x = df.values

N=10000
t = np.linspace(0, 1, N)
n=np.array([10,20,40,50,100,200,400,500,1000])
[P, r, Fr, Yr] = DFA(t, x[:,1], n)
    

plt.plot(r, Fr, '.', label='Fr')  
plt.plot(r, Yr, label='Yr')       
plt.legend()                      
plt.show()        



