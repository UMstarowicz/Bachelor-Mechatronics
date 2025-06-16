#importy potrzebnych bibliotek, cv2 do obróbki obrazów, numpy do operacji na macierzach, picamera do obsługi hardware, 
#requests i IO do komunikacji bezprzewodowej, PIL do konwersji obrazów do odpowiedniego formatu, tflite do uruchamiania modeli uczenia głębokiego na raspberry

import cv2
import numpy as np
from picamera2 import Picamera2
import time
import requests
import io
import PIL
import datetime
import tflite_runtime.interpreter as tflite


#przygotowanie zmiennych globalnych oraz dektektora twarzy (w dwóch wersjach)
movement_detected = False
face_detected = False
face_detector = cv2.CascadeClassifier('/home/tele/Desktop/haarcascade_frontalface_default.xml')
interpreter = tflite.Interpreter('model.tflite')
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

#funkcja porównoująca różnicę pomiędzy następującymi klatkami, umożliwiająca stwierdzenie wystąpienia ruchu
#najprostszy wariant tej funkcjonalności, wykorzystany ze względu na niskie zużycie mocy obliczeniowych
def detect_motion(prev_frame, curr_frame, detect_th):
    global movement_detected
    frame_diff = np.sum(np.abs(prev_frame - curr_frame))
    if frame_diff > detect_th:
        movement_detected = True
        
#detekcja twarzy z wykorzystaniem modelu uczenia głębokiego
def detect_face_nn(frame, interpreter):
    img = (cv2.resize(frame, (256,256))/255).astype('float32')
    img = np.expand_dims(img,0) #preprocessing klatki tak aby pasowała do oczekiwanego wejścia sieci
    interpreter.set_tensor(input_details[0]['index'], img) 
    interpreter.invoke() #ustawienie wskaźnika na początek danych, przepuszczenie i przez sieć
    output_data_bbox = interpreter.get_tensor(output_details[0]['index'])
    output_data_class = interpreter.get_tensor(output_details[1]['index'])
    #odczytanie i zwrot poza funkcję wyników
    cv2.rectangle(frame, (output_data_bbox[0],output_data_bbox[1]),
                (output_data_bbox[0]+output_data_bbox[2], output_data_bbox[1]+output_data_bbox[3]), (0,255,0),4)
    return output_data_class > 0.9, output_data_bbox

#detekcja twarzy z wykorzystaniem kaskad Haara
def detect_face_haar(frame, detector):
    global face_detected
    face_frame = cv2.flip(frame,0)
    face_frame = cv2.cvtColor(face_frame, cv2.COLOR_RGB2BGR)
    grey = cv2.cvtColor(face_frame, cv2.COLOR_BGR2GRAY) #przygotwanie klatki
    face = detector.detectMultiScale(grey, 1.1,5) #uruchomienia algorytmu wykrywania twarzy
    if len(face) != 0:
        face_detected = True
    for (x,y,w,h) in face:
        cv2.rectangle(face_frame, (x,y), (x+w, y+h), (0,255,0),4) #wyrysowanie bouding-boxu na twarzy
    return face_frame #zwrot klatki z dorysowanym bounding boxem

def send_frame(frame): #przesyłanie klatki na serwer
    url = 'http://localhost:8000' #tymczasowy serwer lokalny

    frame_bytes = io.BytesIO()
    img = PIL.Image.fromarray(frame)
    img.save(frame_bytes, format='JPEG')
    frame_bytes.seek(0) #zapisanie obrazu jako buforu bitów w celu przesłania 

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    message = f"Face detected at {timestamp}"
    files = {
        'image': ('image.jpg', frame_bytes.read(), 'image/jpeg'),
        'message': (None, message)
    } #przygotowanie i wysłanie wiadomości na serwer z połączenia timestampu oraz klatki
    response = requests.post(url, files=files) 

picam2 = Picamera2()
picam2.configure(picam2.create_preview_configuration(main = {'format': 'RGB888', 'size' : (640,480)}))
picam2.start() #konfuguracja kamery

time.sleep(1)
prev_frame = picam2.capture_array('main')
threshold = 0.8 * np.sum(prev_frame) #rejestracja pierwszej klatki i wyliczenie progu wykryacia ruchu

while True: #pętla realizująca zaimplementowane funkcjonalności w kolejności wykrywanie ruchu, szukanie twarzy,
    # po pozytywnym wyniku tych dwóch opcji przesłanie klatki na serwer
    time.sleep(1)
    curr_frame = picam2.capture_array('main')
    detect_motion(prev_frame, curr_frame, threshold)
    frame_to_send = detect_face_haar(curr_frame, face_detector)
    if movement_detected == True and face_detected == True:
        send_frame(frame_to_send)
        movement_detected = False
        face_detected = False
    prev_frame = curr_frame

