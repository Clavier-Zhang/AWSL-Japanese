from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Conv2D, Flatten, Dropout, MaxPooling2D
from tensorflow.keras.preprocessing.image import ImageDataGenerator

import os
import numpy as np
import matplotlib.pyplot as plt





import scipy.misc
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.models import Sequential
from keras.preprocessing.image import ImageDataGenerator
from keras.utils import np_utils
from sklearn.model_selection import train_test_split


# Kaggle dir
# hiragana_train_dir = '../input/hiragana/train/train'
# hiragana_validation_dir = '../input/hiragana/validation/validation'

# Local dir
hiragana_train_dir = '/Users/clavier/Desktop/awsl-japan101/CNN_Training/hiragana/train'
hiragana_validation_dir = '/Users/clavier/Desktop/awsl-japan101/CNN_Training/hiragana/validation'

# Constants
batch_size = 64
IMG_HEIGHT = 64
IMG_WIDTH = 64

image_gen_train = ImageDataGenerator(
                    rescale=1./255,
                    rotation_range=15,
                    width_shift_range=.15,
                    height_shift_range=.15,
                    zoom_range=0.2
                    )

                    
train_generator = image_gen_train.flow_from_directory(batch_size=batch_size,
                                                           directory=hiragana_train_dir,
                                                           shuffle=True,
                                                           color_mode="grayscale",
                                                           target_size=(IMG_HEIGHT, IMG_WIDTH),
                                                           class_mode="categorical")

valid_generator = image_gen_train.flow_from_directory(batch_size=batch_size,
                                                           directory=hiragana_validation_dir,
                                                           color_mode="grayscale",
                                                           target_size=(IMG_HEIGHT, IMG_WIDTH),
                                                           class_mode="categorical")



# # View samples
# sample_training_images, _ = next(train_generator)
# # This function will plot images in the form of a grid with 1 row and 5 columns where images are placed in each column.
# def plotImages(images_arr):
#     fig, axes = plt.subplots(1, 5, figsize=(20,20))
#     axes = axes.flatten()
#     for img, ax in zip( images_arr, axes):
#         # print(img)
#         print(img)
#         ax.imshow(img, cmap=plt.cm.binary)
#         ax.axis('off')
#     plt.tight_layout()
#     plt.show()
# plotImages(sample_training_images[:5])
# print(sample_training_images[0].shape)



# model = Sequential([

#     Conv2D(32, (3, 3), activation='relu', input_shape=(IMG_HEIGHT, IMG_WIDTH ,1)),


#     Conv2D(32, (3, 3), activation='relu'),
#     MaxPooling2D(pool_size=(2, 2)),
#     Dropout(0.5),
#     Conv2D(64, (3, 3), activation='relu'),
#     Conv2D(64, (3, 3), activation='relu'),

#     MaxPooling2D(pool_size=(2, 2)),
#     Dropout(0.5),



#     Flatten(),
#     Dense(256, activation='relu'),

#     Dropout(0.5),
#     Dense(71, activation='softmax')
# ])
nb_classes = 71
model = Sequential()

def model_6_layers():
    model.add(Conv2D(32, 3, 3, input_shape=(IMG_HEIGHT, IMG_WIDTH ,1)))
    model.add(Activation('relu'))
    model.add(Conv2D(32, 3, 3))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Dropout(0.5))

    model.add(Conv2D(64, 3, 3))
    model.add(Activation('relu'))
    model.add(Conv2D(64, 3, 3))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Dropout(0.5))

    model.add(Flatten())
    model.add(Dense(256))
    model.add(Activation('relu'))
    model.add(Dropout(0.5))
    model.add(Dense(nb_classes))
    model.add(Activation('softmax'))

model_6_layers()


model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

model.summary()




STEP_SIZE_TRAIN=train_generator.n//train_generator.batch_size
STEP_SIZE_VALID=valid_generator.n//valid_generator.batch_size
history = model.fit_generator(generator=train_generator,
                    steps_per_epoch=STEP_SIZE_TRAIN,
                    validation_data=valid_generator,
                    validation_steps=STEP_SIZE_VALID,
                    epochs=20
)
for k in model.layers:
    if type(k) is Dropout:
        model.layers.remove(k)
        
model.save('hiraganaModel.h5')

# History
# acc = history.history['accuracy']
# val_acc = history.history['val_accuracy']
# loss = history.history['loss']
# val_loss = history.history['val_loss']
# epochs_range = range(20)
# plt.figure(figsize=(8, 8))
# plt.subplot(1, 2, 1)
# plt.plot(epochs_range, acc, label='Training Accuracy')
# plt.plot(epochs_range, val_acc, label='Validation Accuracy')
# plt.legend(loc='lower right')
# plt.title('Training and Validation Accuracy')
# plt.subplot(1, 2, 2)
# plt.plot(epochs_range, loss, label='Training Loss')
# plt.plot(epochs_range, val_loss, label='Validation Loss')
# plt.legend(loc='upper right')
# plt.title('Training and Validation Loss')
# plt.show()







# model_new.save('hiraganaModel.h5')
# labels = (train_generator.class_indices)
# labels = list(labels.keys())
# print(labels)
def hex_to_jp(hex):
    b = b'\033$B' + bytes.fromhex(hex)
    c = b.decode('iso2022_jp')
    return c
# labels = [hex_to_jp(label[2:]) for label in labels]
# print(labels)

# for k in model.layers:
#     if type(k) is Dropout:
#         model.layers.remove(k)
        
model.save('hiraganaModel.h5')