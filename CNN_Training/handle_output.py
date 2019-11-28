
import tensorflow as tf
# import numpy as np
import tfcoreml
import coremltools







# import coremltools

# ['0x2422', '0x2424', '0x2426', '0x2428', '0x242a', '0x242b', '0x242c', '0x242d', '0x242e', '0x242f', '0x2430', '0x2431', '0x2432', '0x2433', '0x2434', '0x2435', '0x2436', '0x2437', '0x2438', '0x2439', '0x243a', '0x243b', '0x243c', '0x243d', '0x243e', '0x243f', '0x2440', '0x2441', '0x2442', '0x2444', '0x2445', '0x2446', '0x2447', '0x2448', '0x2449', '0x244a', '0x244b', '0x244c', '0x244d', '0x244e', '0x244f', '0x2450', '0x2451', '0x2452', '0x2453', '0x2454', '0x2455', '0x2456', '0x2457', '0x2458', '0x2459', '0x245a', '0x245b', '0x245c', '0x245d', '0x245e', '0x245f', '0x2460', '0x2461', '0x2462', '0x2464', '0x2466', '0x2468', '0x2469', '0x246a', '0x246b', '0x246c', '0x246d', '0x246f', '0x2472', '0x2473']

output_labels = [
    'あ', 'い', 'う', 'え', 'お', 
    'か', 'が', 'き', 'ぎ', 'く', 'ぐ', 'け', 'げ', 'こ', 'ご', 
    'さ', 'ざ', 'し', 'じ', 'す', 'ず', 'せ', 'ぜ', 'そ', 'ぞ', 
    'た', 'だ', 'ち', 'ぢ', 'つ', 'づ', 'て', 'で', 'と', 'ど', 
    'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ば', 'ぱ', 'ひ', 'び', 
    'ぴ', 'ふ', 'ぶ', 'ぷ', 'へ', 'べ', 'ぺ', 'ほ', 'ぼ', 'ぽ', 
    'ま', 'み', 'む', 'め', 'も', 'や', 'ゆ', 'よ', 'ら', 'り', 
    'る', 'れ', 'ろ', 'わ', 'を', 'ん']

scale = 1/255.

coreml_model = coremltools.converters.keras.convert('./hiraganaModel.h5',
                                                    input_names='image',
                                                    image_input_names='image',
                                                    output_names='output',
                                                    class_labels= output_labels,
                                                    image_scale=scale)

                                                    
# coreml_model.author = 'Zhang Yichi'
# coreml_model.license = 'MIT'
# coreml_model.short_description = 'Detect hiragana character from handwriting'
# coreml_model.input_description['image'] = 'Grayscale image containing a handwritten character'
# coreml_model.output_description['output'] = 'Output a character in hiragana'

# convert by providing a Keras model object
# import tensorflow as tf 

# keras_model = tf.keras.models.load_model("hiraganaModel.h5")
# print(keras_model.input.name)
# print(keras_model.input_shape)
# print(keras_model.output.name)


# mlmodel = coremltools.converters.keras.convert(keras_model)



# coreml_model.save('hiraganaModel.mlmodel')