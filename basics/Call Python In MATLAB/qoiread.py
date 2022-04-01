##import qoi
##import numpy as np
##def myfunc(path):
##    """Display message."""
##    rgb=qoi.read(path)
##    bites = qoi.encode(rgb)
##    rgb_decoded = qoi.decode(bites)
##    return np.array_equal(rgb, rgb_decoded)
import numpy as np
import qoi
import cv2
def myfunc2(path):
    # Get your image as a numpy array (OpenCV, Pillow, etc. but here we just create a bunch of noise)
    #rgb = np.random.randint(low=0, high=255, size=(224, 244, 3)).astype(np.uint8)0
    #path="C:\\Users\\prana\\OneDrive\\Pictures\\Camera Roll\\WIN_20210620_10_51_31_Pro.jpg"
    rgb=cv2.imread(path)
    # Write it:
    _ = qoi.write("img.qoi", rgb)

    # Read it and check it matches (it should, as we're lossless)
    rgb_read = qoi.read("img.qoi")
    assert np.array_equal(rgb, rgb_read)
    print(np.array_equal(rgb, rgb_read))

    # Likewise for encode/decode to/from bytes:
    bites = qoi.encode(rgb)
    rgb_decoded = qoi.decode(bites)
    assert np.array_equal(rgb, rgb_decoded)
myfunc2("C:\\Users\\prana\\OneDrive\\Pictures\\Camera Roll\\WIN_20210620_10_51_31_Pro.jpg")
def myfunc(rgb):
    # Get your image as a numpy array (OpenCV, Pillow, etc. but here we just create a bunch of noise)
    #rgb = np.random.randint(low=0, high=255, size=(224, 244, 3)).astype(np.uint8)0
    #path="C:\\Users\\prana\\OneDrive\\Pictures\\Camera Roll\\WIN_20210620_10_51_31_Pro.jpg"
    #rgb=cv2.imread(path)
    # Write it:
    #_ = qoi.write("img.qoi", rgb)

    # Read it and check it matches (it should, as we're lossless)
    #rgb_read = qoi.read("img.qoi")
    #assert np.array_equal(rgb, rgb_read)
    #print(np.array_equal(rgb, rgb_read))

    # Likewise for encode/decode to/from bytes:
    rgb=cv2.reshape(rgb,64,64,3)
    bites = qoi.encode(rgb)
    rgb_decoded = qoi.decode(bites)
    assert np.array_equal(rgb, rgb_decoded)
    return bytes.flatten()
def myfunc3(path):
    # Get your image as a numpy array (OpenCV, Pillow, etc. but here we just create a bunch of noise)
    #rgb = np.random.randint(low=0, high=255, size=(224, 244, 3)).astype(np.uint8)0
    path="C:\\Users\\prana\\OneDrive\\Pictures\\Camera Roll\\WIN_20210620_10_51_31_Pro.jpg"
    rgb=cv2.imread(path)
    # Write it:
    _ = qoi.write("img.qoi", rgb)

    # Read it and check it matches (it should, as we're lossless)
    rgb_read = qoi.read("img.qoi")
    assert np.array_equal(rgb, rgb_read)
    print(np.array_equal(rgb, rgb_read))

    # Likewise for encode/decode to/from bytes:
    bites = qoi.encode(rgb)
    rgb_decoded = qoi.decode(bites)
    assert np.array_equal(rgb, rgb_decoded)