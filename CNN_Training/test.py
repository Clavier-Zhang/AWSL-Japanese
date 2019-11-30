# tensorflor==2.0.0
# tfcoreml==3.1
# https://blog.usejournal.com/training-a-tensorflow-image-classification-model-and-integrating-it-into-ios-apps-148fe513f6e
import tensorflow as tf
import tfcoreml
import numpy as np
import coremltools

# keras_model = tf.keras.Sequential([
#     tf.keras.layers.Flatten(input_shape=(28, 28)),
#     tf.keras.layers.Dense(128, activation='relu'),
#     tf.keras.layers.Dense(10, activation='softmax')
# ])

IMG_HEIGHT = 64
IMG_WIDTH = 64
keras_model = tf.keras.Sequential([
    # tf.keras.layers.Flatten(input_shape=(IMG_HEIGHT, IMG_WIDTH, 1)),
    tf.keras.layers.Conv2D(32, (3, 3), activation='relu', input_shape=(IMG_HEIGHT, IMG_WIDTH ,1), data_format="channels_last"),


    tf.keras.layers.Conv2D(32, (3, 3), activation='relu'),
    tf.keras.layers.MaxPooling2D(pool_size=(2, 2)),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Conv2D(64, (3, 3), activation='relu'),
    tf.keras.layers.Conv2D(64, (3, 3), activation='relu'),

    tf.keras.layers.MaxPooling2D(pool_size=(2, 2)),
    tf.keras.layers.Dropout(0.5),



    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(256, activation='relu'),

    # Dropout(0.5),
    tf.keras.layers.Dense(71, activation='softmax')
])

keras_model.save('/tmp/keras_model.h5')
labels = [
    'あ', 'い', 'う', 'え', 'お', 
    'か', 'が', 'き', 'ぎ', 'く']
# print input name, output name, input shape
# print(keras_model.input.name)
# print(keras_model.input_shape)
# print(keras_model.output.name)
output_labels = [
    'あ', 'い', 'う', 'え', 'お', 
    'か', 'が', 'き', 'ぎ', 'く', 'ぐ', 'け', 'げ', 'こ', 'ご', 
    'さ', 'ざ', 'し', 'じ', 'す', 'ず', 'せ', 'ぜ', 'そ', 'ぞ', 
    'た', 'だ', 'ち', 'ぢ', 'つ', 'づ', 'て', 'で', 'と', 'ど', 
    'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ば', 'ぱ', 'ひ', 'び', 
    'ぴ', 'ふ', 'ぶ', 'ぷ', 'へ', 'べ', 'ぺ', 'ほ', 'ぼ', 'ぽ', 
    'ま', 'み', 'む', 'め', 'も', 'や', 'ゆ', 'よ', 'ら', 'り', 
    'る', 'れ', 'ろ', 'わ', 'を', 'ん'] 

# model = tfcoreml.convert(tf_model_path='/tmp/keras_model.h5',
#                          input_name_shape_dict={'flatten_input': (1, 28, 28)},
#                          output_feature_names=['Identity'],
#                          minimum_ios_deployment_target='13',
#                         #  class_labels=labels
#                          )

# new_model = tfcoreml.convert(tf_model_path='./hiraganaModel.h5',
#                          input_name_shape_dict={'conv2d_input': (1, 64, 64, 1)},
#                          output_feature_names=['Identity'],
#                          minimum_ios_deployment_target='13',
#                         #  class_labels=labels
#                          )

# model = coremltools.converters.keras.convert(
#                          tf.keras.models.load_model('./hiraganaModel.h5'),
#                          input_name_shape_dict={'conv2d_input': (1, 64, 64, 1)},
#                          output_feature_names=['Identity'],
#                          class_labels=output_labels,
#                          minimum_ios_deployment_target='13',
#                          image_scale=1/255)

model = tfcoreml.convert(tf_model_path='/tmp/keras_model.h5',
                         input_name_shape_dict={'conv2d_input': (1, 64, 64, 1)},
                         output_feature_names=['Identity'],
                         minimum_ios_deployment_target='13')

# model = coremltools.converters.tensorflow.convert(
#                         filename='/tmp/keras_model.h5',
#                          input_name_shape_dict={'flatten_input': (1, 28, 28)},
#                          output_feature_names=['Identity'],
#                         #  class_labels=output_labels,
#                          minimum_ios_deployment_target='13',
#                          image_scale=1/255)

# model.save('./keras_model.mlmodel')


# run predictions with fake image as an input
# fake_image = np.random.ra/nd(1, 64, 64, 1)

# keras_predictions = keras_model.predict(fake_image)
# print(keras_predictions[:10])

# coreml_predictions = model.predict({'conv2d_input': fake_image})['Identity']
# print(coreml_predictions)

# assert(np.allclose(keras_predictions, coreml_predictions))