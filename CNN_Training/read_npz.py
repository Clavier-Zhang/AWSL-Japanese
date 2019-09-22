import struct
import numpy as np
from PIL import Image

record_size = 8199

# Retrive a record
def read_record_ETL8G(f):
    s = f.read(record_size)
    r = struct.unpack('>2H8sI4B4H2B30x8128s11x', s)
    iF = Image.frombytes('F', (128, 127), r[14], 'bit', 4)
    iL = iF.convert('L')
    return r + (iL,)


def read_hiragana_ETL8G():
    # Type of characters = 70, person = 160, y = 127, x = 128
    ary = np.zeros([71, 160, 127, 128], dtype=np.uint8)

    for file_id in range(1, 33):
        filename = '../../ETL8G/ETL8G_{:02d}'.format(file_id)
        with open(filename, 'rb') as f:
            for dataset_id in range(5):
                moji = 0
                for record_id in range(956):
                    r = read_record_ETL8G(f)            
                    if b'.HIRA' in r[2] or b'.WO.' in r[2]:
                        if not b'KAI' in r[2] and not b'HEI' in r[2]:
                            ary[moji, (file_id - 1) * 5 + dataset_id] = np.array(r[-1])
                            moji += 1
                            
    np.savez_compressed("hiragana.npz", ary)


read_hiragana_ETL8G()