import struct
import bitstruct
import numpy as np
from PIL import Image, ImageEnhance
import os
from skimage import transform 

hiragana_keys = set(['0x2422', '0x2424', '0x2426', '0x2428', '0x242a', '0x242b', '0x242c', '0x242d', '0x242e', '0x242f', 
                    '0x2430', '0x2431', '0x2432', '0x2433', '0x2434', '0x2435', '0x2436', '0x2437', '0x2438', '0x2439', '0x243a', '0x243b', '0x243c', '0x243d', '0x243e', '0x243f', 
                    '0x2440', '0x2441', '0x2442', '0x2444', '0x2445', '0x2446', '0x2447', '0x2448', '0x2449', '0x244a', '0x244b', '0x244c', '0x244d', '0x244e', '0x244f', 
                    '0x2450', '0x2451', '0x2452', '0x2453', '0x2454', '0x2455', '0x2456', '0x2457', '0x2458', '0x2459', '0x245a', '0x245b', '0x245c', '0x245d', '0x245e', '0x245f', 
                    '0x2460', '0x2461', '0x2462', '0x2464', '0x2466', '0x2468', '0x2469', '0x246a', '0x246b', '0x246c', '0x246d', '0x246f', 
                    '0x2472', '0x2473'])

counts = {}

def read_record_ETL8G(f, record_size, token):
    s = f.read(record_size)
    r = struct.unpack(token, s)
    iF = Image.frombytes('F', (128, 127), r[14], 'bit', 4)
    iL = iF.convert('L')
    return r + (iL,)

def read_hiragana_ETL8G():
    for file_id in range(1, 33):
        filename = '../../ETL8G/ETL8G_{:02d}'.format(file_id)
        with open(filename, 'rb') as f:
            for dataset_id in range(5):
                for record_id in range(956):
                    r = read_record_ETL8G(f, 8199, '>2H8sI4B4H2B30x8128s11x') 
                    code = str(hex(r[1]))
                    print('file id: ', file_id, 'dataset id: ', dataset_id, 'record: ', record_id)
                    if code in hiragana_keys:
                        image = r[-1]
                            
                        if code not in counts:
                            counts[code] = 0
                        counts[code] += 1

                        image = ImageEnhance.Contrast(image)
                        image = image.enhance(32)

                        path = './hiragana/train' if counts[code] <= 300 else './hiragana/validation'
                        
                        save_image(image, code, path)

def read_hiragana_ETL9G():
    for file_id in range(1, 51):
        filename = '../../ETL9G/ETL9G_{:02d}'.format(file_id)
        with open(filename, 'rb') as f:
            for dataset_id in range(1, 5):
                for record_id in range(3036):
                    
                    r = read_record_ETL8G(f, 8199, '>2H8sI4B4H2B34x8128s7x') 
                    code = str(hex(r[1]))
                    
                    if code in hiragana_keys:
                        image = r[-1]  
                        if code not in counts:
                            counts[code] = 0
                        counts[code] += 1
                        
                        image = ImageEnhance.Contrast(image)
                        image = image.enhance(32)
                        w, h = image.size
                        image = image.crop((15, 0, w, h))
    
                        print('file id: ', file_id, 'dataset id: ', dataset_id, 'record: ', record_id)


                        path = './hiragana/train' if counts[code] <= 300 else './hiragana/validation'
                        
                        save_image(image, code, path)
 

def save_image(image, code, path):
    d = os.path.join(path, code)
    try:
        os.mkdir(d)
    except OSError:
        print ("Creation of the directory %s failed" % d)
    else:
        print ("Successfully created the directory %s " % d)
    file_name = code+'.'+str(counts[code])+'.jpg'
    image.save(os.path.join(d, file_name))


read_hiragana_ETL9G()
read_hiragana_ETL8G()

print(counts)
print(len(counts))
print(counts.keys())