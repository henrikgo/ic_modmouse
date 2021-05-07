import datetime as dt
import sys


# print_message()
def print_message(s_message):
    b_ret = False
    try:
        print(dt.datetime.now().strftime("%d-%m-%Y %H:%M:%S") + ' ' + s_message)
        b_ret = True
    finally:
        return b_ret


# print_error()
def print_error(s_message):
    b_ret = False
    try:
        print(dt.datetime.now().strftime("%d-%m-%Y %H:%M:%S") + ' ' + s_message)
        b_ret = True
    finally:
        return b_ret


# print/update progress bar
def progress_bar(proportion_complete):
    b_ret = False
    try:
        if (proportion_complete >= 0) and (proportion_complete <= 1):
            num_eq = round((20/100)*proportion_complete*100)
            sys.stdout.write('\r')
            sys.stdout.write("[%-20s] %d%% complete" % ('='*num_eq, proportion_complete*100))
            sys.stdout.flush()
            if proportion_complete >= 1:
                print('\r')
        b_ret = True
    finally:
        return b_ret


# rolling_mean()
def rolling_mean(arr, num_frames):
    d_ret = None
    try:
        n_samples_per_run = np.floor(num_frames / 2)  # initialise
        d_num_smp = len(arr)
        d_data_f = np.zeros(arr.shape)
        d_data_r = np.zeros(arr.shape)
        for i in range(0, d_num_smp, 1):  # forward run
            if i > n_samples_per_run-1:
                d_data_to_mean = arr[int(i-n_samples_per_run+1):int(i+1), ]
            else:
                d_data_to_mean = arr[int(0):int(i+1), ]
            d_data_f[i] = np.mean(d_data_to_mean)
        for i in range(d_num_smp, 0, -1):  # reverse run
            if (d_num_smp - i + 1) > n_samples_per_run:
                d_data_to_mean = d_data_f[int(i-1):int(i+n_samples_per_run-1)]
            else:
                d_data_to_mean = d_data_f[int(i-1):d_num_smp, ]
            d_data_r[i-1] = np.mean(d_data_to_mean)
        d_ret = d_data_r
    except Exception as ex:
        print_error('unexpected error in rolling_mean(), ' + str(ex))
    finally:
        return d_ret
