import cv2
import numpy as np
'''you shall use 'pip install opencv-python' command before import cv package'''

# define constant
sample_rate = 1

GS_threshold = 2.5
INIT_FRAME = 100

##################

def colorFilter(IMG, low, high):
    IMG2 = cv2.GaussianBlur(IMG, (10,10), 5)
    IMG2 = cv2.cvtColor(IMG2, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(IMG2, np.array(low), np.array(high))
    IMG = cv2.bitwise_and(IMG, IMG, mask=mask)
    return IMG

def trackBarInit():
    cv2.namedWindow('trackbar')
    cv2.resizeWindow('trackbar',300,500)
    cv2.createTrackbar('H_min','trackbar',20,50,np.empty)
    cv2.createTrackbar('H_max','trackbar',179,179,np.empty)
    cv2.createTrackbar('S_min','trackbar',0,255,np.empty)
    cv2.createTrackbar('S_max','trackbar',255,255,np.empty)
    cv2.createTrackbar('V_min','trackbar',0,255,np.empty)
    cv2.createTrackbar('V_max','trackbar',255,255,np.empty)

def getTrackBarValue():
    Hmin = cv2.getTrackbarPos('H_min','trackbar')
    Hmax = cv2.getTrackbarPos('H_max','trackbar')
    Smin = cv2.getTrackbarPos('S_min','trackbar')
    Smax = cv2.getTrackbarPos('S_max','trackbar')
    Vmin = cv2.getTrackbarPos('V_min','trackbar')
    Vmax = cv2.getTrackbarPos('V_max','trackbar')
    return np.array([Hmin,Smin,Vmin]),np.array([Hmax,Smax,Vmax])

def main():
    capture = cv2.VideoCapture(0,cv2.CAP_DSHOW)
    count = 0
    # trackBarInit()
    SIGMA_X = None
    SIGMA_X_2 = None
    FRAME_COUNT = None

    
    capture.set(cv2.CAP_PROP_AUTOFOCUS, 1)
    # capture.set(cv2.CAP_PROP_AUTO_EXPOSURE, 1)
    # capture.set(cv2.CAP_PROP_AUTO_WB, 1)
    # capture.set(cv2.CAP_PROP_SETTINGS, 1)
    while True:
    
        # read img from camera
        ret, rawIMG = capture.read()
        IMG = np.array(cv2.cvtColor(rawIMG,cv2.COLOR_BGR2GRAY),np.uint32)
        if count == 0:
            SIGMA_X   = IMG # + np.ones(np.array(IMG).shape)
            SIGMA_X_2 = np.multiply(IMG # + np.array(np.ones(np.array(IMG).shape),np.uint32)
            ,IMG)
            count += 1
            FRAME_COUNT = np.array(np.ones(IMG.shape) * INIT_FRAME, np.uint32)
            continue
        elif count < INIT_FRAME:
            SIGMA_X   = SIGMA_X + IMG
            SIGMA_X_2 = SIGMA_X_2 + np.multiply(IMG
            ,IMG)
            count += 1
            FRAME_COUNT = np.array(np.ones(IMG.shape) * INIT_FRAME, np.uint32)
            if count == INIT_FRAME:
                print("\n initialize finished \n")
            continue
        
        

        # skip img for sample rate
        count += 1
        if count % sample_rate > 0: continue

        # compare current img with initial Gausian model if in 1 stdev or not
        average = np.divide(SIGMA_X, FRAME_COUNT)
        stdev_square   = np.abs( np.divide(SIGMA_X_2, FRAME_COUNT) - np.multiply(np.divide(SIGMA_X, FRAME_COUNT), np.divide(SIGMA_X, FRAME_COUNT)))

        offset_stdev = np.abs(np.divide( (IMG - average) , np.sqrt(stdev_square))) 

        filter = offset_stdev > GS_threshold
        

        ### update GS parameter
        # FRAME_COUNT = filter + FRAME_COUNT
        # SIGMA_X = SIGMA_X + np.multiply(filter, IMG)
        # SIGMA_X_2 = SIGMA_X_2 + np.multiply(np.multiply(filter, IMG),IMG)


        
        # offset_stdev = np.array(offset_stdev, np.uint8)
        filter = np.array(filter, np.uint8)

        # for i in range(0,np.array(stdev_square).shape[0],30):
        #     for j in range(0,np.array(stdev_square).shape[1],30):
        #         print(FRAME_COUNT[i,j],end=' ')
        #     print()
        # print('\n\n\n')
       
        masked_img = cv2.bitwise_and(rawIMG, rawIMG, mask = filter)
        
        # # show img
        cv2.imshow('img', masked_img)

        # quit when press key 'q' 
        if cv2.waitKey(1) == ord('q'):
            capture.release()
            cv2.destroyAllWindows()
            # break
        

if __name__ == '__main__':
    main()