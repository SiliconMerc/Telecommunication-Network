import numpy as np
import qoi
import cv2
def DecimalToBinary(num):
    binary=[]
    for i in range(8):
        binary=[num % 2]+binary
        num=(num // 2)
    return binary
    # print(num % 2, end = '')
# print(DecimalToBinary(254))
def BinaryToDecimal(binary):
    num=0
    # binary.reverse()
    for x in binary:
        num=num*2+x
    return num
def encode(rgb):
    #Input a 1D array of image bits
    rgb=np.array(rgb)
    rgb=np.reshape(rgb,(64,64,3))
    # print(rgb.shape)
    # rgb=cv2.resize(rgb,(64,64))
    bites = qoi.encode(rgb)
    print(list(bites)[0:10])
    bits=[]
    for num in list(bites):
        bits+=DecimalToBinary(num)
    return bits
def decode(bits):
    #Input a 1D array of image bits received after deomdulation
    bites=[]
    for i in range(0,len(bits)-1,8):
        bites+=[BinaryToDecimal(bits[i:i+8])]
    print(bites[0:10])
    bites=bytes(bites)
    rgb_decoded = qoi.decode(bites)
    # cv2.imshow("Test",rgb_decoded)
    # cv2.waitKey(0)
    return rgb_decoded.flatten()
# img=cv2.imread("C:\\Users\\prana\\OneDrive\\Pictures\\Camera Roll\\WIN_20210620_10_51_31_Pro.jpg")
# img=cv2.resize(img,(64,64))
# decode(encode(img.flatten()))