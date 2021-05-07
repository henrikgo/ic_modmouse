import scipy.io as spio
import numpy as np
import os.path


def loadmat(filename):
    '''
    this function should be called instead of direct spio.loadmat
    as it cures the problem of not properly recovering python dictionaries
    from mat files. It calls the function check keys to cure all entries
    which are still mat-objects
    '''
    def _check_keys(d):
        '''
        checks if entries in dictionary are mat-objects. If yes
        todict is called to change them to nested dictionaries
        '''
        for key in d:
            if isinstance(d[key], spio.matlab.mio5_params.mat_struct):
                d[key] = _todict(d[key])
        return d

    def _todict(matobj):
        '''
        A recursive function which constructs from matobjects nested dictionaries
        '''
        d = {}
        for strg in matobj._fieldnames:
            elem = matobj.__dict__[strg]
            if isinstance(elem, spio.matlab.mio5_params.mat_struct):
                d[strg] = _todict(elem)
            elif isinstance(elem, np.ndarray):
                d[strg] = _tolist(elem)
            else:
                d[strg] = elem
        return d

    def _tolist(ndarray):
        '''
        A recursive function which constructs lists from cellarrays
        (which are loaded as numpy ndarrays), recursing into the elements
        if they contain matobjects.
        
        Return dictionary contains variables, lists or dictionaries
        It can also contain type scipy.io.matlab.mio5_params.mat_struct for which 
        field names can be accessed as "var._fieldnames" (instead of list(var))
        Field values can be obtained as var.field1, var.field2 etc rather than var['field1']...
        '''
        elem_list = []
        for sub_elem in ndarray:
            if isinstance(sub_elem, spio.matlab.mio5_params.mat_struct):
                elem_list.append(_todict(sub_elem))
            elif isinstance(sub_elem, np.ndarray):
                elem_list.append(_tolist(sub_elem))
            else:
                elem_list.append(sub_elem)
        return elem_list

    data = spio.loadmat(filename, struct_as_record=False, squeeze_me=True)
    # for k in ['__header__', '__version__', '__globals__', '__function_workspace__']:
    #     del data[k]
    return _check_keys(data)


# get_mat_data()
def get_mat_data(s_mat_file, s_struct, s_field_list):
    ret_list = list()
    try:
        if not os.path.isfile(s_mat_file):  # check for file
            raise Exception('file [' + s_mat_file + '] not found')
        o_mat = spio.loadmat(s_mat_file)  # load it
        o_struct = o_mat[s_struct][0, 0]
        for s_field in s_field_list:
            ret_list.append(np.array(o_struct[s_field]))
    except Exception as ex:
        print_error('unexpected error in get_mat_data(), ' + str(ex))
    finally:
        return ret_list
