import scipy.misc
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.models import Sequential
from keras.preprocessing.image import ImageDataGenerator
from keras.utils import np_utils
from sklearn.model_selection import train_test_split
import struct
import numpy as np
from PIL import Image
import skimage

# 71 characters
nb_classes = 71
# input image dimensions
img_rows, img_cols = 32, 32

ary = np.load("hiragana.npz")['arr_0'].reshape([-1, 127, 128]).astype(np.float32) / 15
X_train = np.zeros([nb_classes * 160, img_rows, img_cols], dtype=np.float32)
for i in range(nb_classes * 160):
    X_train[i] = skimage.transform.resize(ary[i], (img_rows, img_cols))
 
 

y_train = np.repeat(np.arange(nb_classes), 160)

X_train, X_test, y_train, y_test = train_test_split(X_train, y_train, test_size=0.2)

# convert class vectors to categorical matrices
y_train = np_utils.to_categorical(y_train, nb_classes)
y_test = np_utils.to_categorical(y_test, nb_classes)

# data augmentation
datagen = ImageDataGenerator(rotation_range=15, zoom_range=0.20)

X_train = np.expand_dims(X_train, axis=3)
X_test = np.expand_dims(X_test, axis=3)


datagen.fit(X_train)






model = Sequential()

def model_6_layers():
    model.add(Conv2D(32, (3, 3), input_shape=(32, 32, 1)))
    model.add(Activation('relu'))
    model.add(Conv2D(32, (3, 3))) 
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Dropout(0.5))

    model.add(Conv2D(64, (3, 3)))
    model.add(Activation('relu'))
    model.add(Conv2D(64, (3, 3)))
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

print("***************")
print(y_test.shape)
print("***************")

model.compile(loss='categorical_crossentropy', 
              optimizer='adam', metrics=['accuracy'])
model.fit_generator(datagen.flow(X_train, y_train, batch_size=16), 
                    samples_per_epoch=X_train.shape[0],
                    nb_epoch=30, validation_data=(X_test, y_test))

for k in model.layers:
    if type(k) is keras.layers.Dropout:
        model.layers.remove(k)
        
model.save('hiraganaModel.h5')