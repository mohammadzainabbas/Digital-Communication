from os import listdir
from os.path import isfile, join
import imutils
import glob
import os
import locale
import numpy as np
import cv2 as cv
import matplotlib.pyplot as plt
import time
import screeninfo

file_path = r'E:\CEME\temp'
##sec = 1
###simg_dir = "" # Enter Directory of all images 
##data_path = os.path.join(file_path,'*g')
##files = glob.glob(data_path)
##data = []
##for f1 in files:
##    cv.imshow('Window',f1)
##    cv.destroyAllWindows()
##    cv.waitKey()
##    time.sleep(sec*1000)
##
##    data.append(img)
##


sec = 1
##for file in os.listdir(file_path):
##    cv.imshow(file)
##    cv.destoryAllWindows()
##    cv.waitKey()
##    time.sleep(sec*1000)
files = [ f for f in listdir(file_path) if isfile(join(file_path,f)) ]

img = np.empty(len(files), dtype=object)

for n in range(0, len(files)):
    img[n] = cv.imread( join(file_path,files[n]), 0 )

print('File loaded')
screen_id = 0
# get the size of the screen
screen = screeninfo.get_monitors()[screen_id]
width, height = screen.width, screen.height
window_name = 'Image'
for n in range(0, len(files)):
    cv.namedWindow(window_name, cv.WND_PROP_FULLSCREEN)
    cv.moveWindow(window_name, screen.x - 1, screen.y - 1)
    cv.setWindowProperty(window_name, cv.WND_PROP_FULLSCREEN, cv.WINDOW_FULLSCREEN)
    cv.imshow(window_name,img[n])
    cv.waitKey()
    cv.destroyAllWindows()
    time.sleep(sec)

print('All done')